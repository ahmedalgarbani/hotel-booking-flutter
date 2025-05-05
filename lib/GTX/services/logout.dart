
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/helper/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Api apiService = Api();

  Future<bool> refreshAccessToken() async {
    
    final prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString('refresh_token');

    if (refreshToken == null) {
      print("No refresh token found.");
      return false;
    }

    print("Old Refresh Token: $refreshToken");

    try {
      final response = await apiService.postt(
        url: "http://192.168.60.85:8000/api/token/refresh/",
        body: {"refresh": refreshToken},
        token: null,  
      );

      if (response != null && response.containsKey('access')) {
        String newAccessToken = response['access'];

        print("New Access Token: $newAccessToken");

        await prefs.setString('access_token', newAccessToken);
        print("Access token refreshed successfully: $newAccessToken");
        return true;
      } else {
        print("Failed to refresh access token: ${response}");
        return false;
      }
    } catch (e) {
      print("Error refreshing token: $e");
      return false;
    }
  }

  Future<void> logOut(BuildContext context) async {
    
    final prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString('refresh_token');
    String? accessToken = prefs.getString('access_token');

    print("Old Access Token: $accessToken");
    print("Old Refresh Token: $refreshToken");

    if (refreshToken == null) {
      print("No refresh token found.");
      Navigator.pushReplacementNamed(context, "/login");
      return;
    }

    if (accessToken == null || accessToken.isEmpty) {
      bool refreshed = await refreshAccessToken();
      if (!refreshed) {
        print("Refresh token expired. Redirecting to login.");
        await prefs.remove('access_token');
        await prefs.remove('refresh_token');
        Navigator.pushReplacementNamed(context, "/login");
        return;
      }
      accessToken = prefs.getString('access_token'); 
    }

    print("Access Token Sent for Logout: $accessToken");

    try {
      var response = await apiService.postt(
        url: "http://192.168.60.85:8000/api/logout/",
        body: {"refresh_token": refreshToken},
        token: accessToken, 
      );

      if (response != null && response.containsKey('message') && response['message'] == 'Logout successful') {
        print("Logout successful");

        await prefs.remove('access_token');
        await prefs.remove('refresh_token');

        Navigator.pushReplacementNamed(context, "/login");
      } else {
        print("Logout failed: ${response}");
      }
    } catch (e) {
      print("Logout failed: $e");
    }
  }
}
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/helper/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hotels/GTX/Models/login_Model.dart';

class ChangePasswordService {
  Future<String?> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
   
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      print('Token is missing.');
      return "Token غير موجود";
    }

    try {
      Map<String, dynamic>? data = await Api().post(
        url: 'http://192.168.60.85:8000/api/change-password/',
        body: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
        token: token,
      );

      if (data != null && data['detail'] != null) {
        print("Password changed successfully.");
        return null; 
      } else if (data != null && data['error'] != null) {
        return data['error'];
      } else {
        return "حدث خطأ غير متوقع";
      }
    } catch (e) {
      print("Exception: $e");
      return "retry to enter the old password";
    }
  }
}


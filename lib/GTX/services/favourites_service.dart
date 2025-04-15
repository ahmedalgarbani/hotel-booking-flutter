import 'dart:convert';
import 'package:hotels/GTX/Models/favroute_model.dart';
import 'package:hotels/GTX/helper/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';

class FavouritesService {
 Future<List<favrourHotelsModel>> getFavourites() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');

  if (token == null) {
    print(". No token found!");
    throw Exception("User not authenticated");
  }

  print("🟢 Using Token: $token");

  List<favrourHotelsModel> data= await Api().getfavrour(
    url: "http://192.168.183.85:8000/api/favourites/",
    token: token,
  );
  print("data hotel data hotel ============================================");
  print("data hotel data hotel ============================================${data}");
  return data;
}

  Future<bool> addToFavourites(int hotelId) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) throw Exception("User not authenticated");

    Map<String, dynamic> body = {
      'hotel': hotelId,  
    };

    var response = await Api().post(
      url: "http://192.168.183.85:8000/api/favourites/",
      body: body,  
      token: token,
    );

    return response != null && response.isNotEmpty;
  } catch (e) {
    print("Error adding to favourites: $e");
    return false;
  }
}



  Future<bool> removeFromFavourites(int hotelId) async {
  try {   
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) throw Exception("User not authenticated");

    String url = "http://192.168.183.85:8000/api/favourites/remove/"; 
    Map<String, dynamic> body = {
      'hotel': hotelId,  
    };

    print("The url ==========: $url"); 

    var response = await Api().delete(
      url: url,
      body:body,
      token: token,
    );

    print("Response from server: $response");
    return response != null;
  } catch (e) {
    print("Error removing from favourites: $e");
    return false;
  }
}





}

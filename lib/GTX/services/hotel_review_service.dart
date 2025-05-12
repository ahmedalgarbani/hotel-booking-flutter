import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/Models/hotel_review_model.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/helper/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HotelReviewService {
  Future<HotelReviewModel> makeReviewHotel({
    required int hotel,
    required int ratingService,
    required int ratingLocation,
    required int ratingValueForMoney,
    required int ratingCleanliness,
    required String review,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) throw Exception("User not authenticated");

    Map<String, dynamic> bodys = {
      'hotel': hotel,
      'rating_service': ratingService,
      'rating_location': ratingLocation,
      'rating_value_for_money': ratingValueForMoney,
      'rating_cleanliness': ratingCleanliness,
      'review': review,
    };

    Map<String, dynamic> data = await Api().postrievew(
      url: 'http://192.168.8.115:8000/api/hotel-reviews/', 
      body: bodys,
      token: token,
    );

    print("data=======================");
    if (data.isEmpty) {
      throw Exception("The request from server is null: $data");
    }

    return HotelReviewModel.fromJson(data);
  }
}

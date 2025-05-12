import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/Models/GuestModel.dart';
import 'package:hotels/GTX/controller/Booking_details_Controller.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/helper/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Addguestserver  {

  
  Future<GuestModel> addGues({
    required int bookingid,
    required String name,
    required String birth_date,
    required String phone,
    required String gender,
    required File? image,
  }) async {

   final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    

    Map<String, dynamic> data = await Api().postgust(
      url: 'http://192.168.8.115:8000/api/create-guest/',
      body: {
        'booking':bookingid,
        'name': name,
        'phone_number': phone,
        'gender': gender,
        'birthday_date': birth_date,
      },
      image: image,
      token: token,
    );
     Get.find<BookingController>().fetchBookings();

    return GuestModel.fromJson(data);
  }
}
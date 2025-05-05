import 'dart:io';

import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/helper/api.dart';
import 'package:hotels/GTX/services/permission.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class GetAllHotels {
  Future<List<HotelsModel>> getAllHotels() async {
    

    final String url = 'http://192.168.60.85:8000/api/hotels/';
    print("url ================= $url");

    List<HotelsModel> data = await Api().get(url: url);
    return data;
  }
}


class GetAllHotelsSearch {
  Future<List<HotelsModel>> getAllHotels({required String nameHotelSearch ,required String locationHotelSearch,required int adult_number ,required int room_number ,required String check_in,required String check_out,required String category_type}) async {
   
    // print("url ================= $url");
    final String url = 'http://192.168.60.85:8000/api/hotels/search/?name=$nameHotelSearch&location=$locationHotelSearch&adult_number=$adult_number&room_number=$room_number&check_in=$check_in&check_out=$check_out&category_type=$category_type';
  List<HotelsModel> data = await Api().get(url:url);
  print("locationHotelSearch");
  print(locationHotelSearch);
  print(adult_number);
  print("room_number");
  print(room_number);
  print("=====================================data $data");
    return data;
  }
}
// class GetAllHotelsSearchlocation {
//   Future<List<HotelsModel>> getAllHotels({required String nameHotelSearch ,required String locationHotelSearch,required int adult_number ,required int room_number ,required String check_in,required String check_out,required String category_type}) async {
//     final String url = 'http://192.168.60.85:8000/api/hotels/search/?room_number=$room_number&check_in=$check_in&check_out=$check_out&adult_number=$adult_number=&location=$locationHotelSearch&category_type=$category_type';
//   List<HotelsModel> data = await Api().get(url:url);
//   print("adult_number");
//   print(adult_number);
//   print("room_number");
//   print(room_number);
//   print("=====================================data $data");
//     return data;
//   }
// }



import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/database.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/Controller_favourites.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/controller/flashbar.dart';
import 'package:hotels/GTX/services/favourites_service.dart';
import 'package:hotels/GTX/services/show_hotel_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Hotelinf extends GetxController {
  SqlDb sqlDb = SqlDb();
  var isLoading = true.obs;
  RxList<Map<String, dynamic>> categories =
      <Map<String, dynamic>>[].obs; // Observable list

  @override
  void onInit() {
    super.onInit();
    readAllData();
  }

  Future<void> readAllData() async {
    isLoading.value = true;
    List<Map> hotelResponse = await sqlDb.readData("SELECT * FROM hotels");

    categories.clear();
    for (var category in hotelResponse) {
      categories.add({
        'hotel_name': category['hotel_name'],
        'hotel_email': category['hotel_email'],
        'hotel_description': category['hotel_description'],
        'id': category['id'],
        'hotel_image': category['hotel_image'] != null
            ? Uint8List.fromList(category['hotel_image'])
            : Uint8List(0),
      });
    }
    isLoading.value = false;
  }
}

class Hotelinfo extends GetxController {
  var hotelsList = <HotelsModel>[].obs;
  var hotelroom = <modelRoomm>[].obs;
   var hotel_name = "".obs;
  var image_hotel = "".obs;
  var room_name = "".obs;
  var hotelroomService = <modelServiceModel>[].obs;
  var hotelroomimage = <modelRoomImagee>[].obs;
  var isFetching = false.obs;
  var isFavorite = false.obs;

 void toggleFavorite() {
    isFavorite.value = !isFavorite.value;  
  }


  @override
  void onInit() {
    super.onInit();
    toggleFavorite();
        fetchHotels(); 

  //    Timer.periodic(Duration(seconds: 1), (timer) {
  //   fetchHotels(); 
  // });
  }

  void fetchHotels() async {
    isFetching.value = true;
    try {
      List<HotelsModel> fetchedHotels = await GetAllHotels().getAllHotels();
      _saveHotelsLocally(fetchedHotels);
      hotelsList.value = fetchedHotels;
    } catch (e) {
      print("Error fetching data: $e");
      hotelsList.value = await _getHotelsLocally();
    } finally {
      isFetching.value = false;
    }
    update();
  }
// final ConfirmController bookingController = Get.find<ConfirmController>();
  void loadHotelRoomsById(int hotelId) {
    final hotel = hotelsList.firstWhereOrNull((h) => h.id == hotelId);

    if (hotel != null) {
    hotel_name.value=  hotel.name;
    image_hotel.value=  hotel.image;
      hotelroom.value = hotel.rooms;
      print("hotel_namehotel_namehotel_namehotel_namehotel_name");
      print("hotel_name");
      print("hotel_name");
      print(hotel_name);
    } else {
      hotelroom.clear(); 
    }
  }
  void loadHotelRoomsServiceById(int room_id) {
    final rooms = hotelroom.firstWhereOrNull((h) => h.id == room_id);
    if (rooms != null) {
          room_name.value=rooms.name;

      hotelroomService.value = rooms.services;
    } else {
      hotelroomService.clear(); 
    }
  }
  void loadHotelRoomsImageById(int room_id) {
    final rooms = hotelroom.firstWhereOrNull((h) => h.id == room_id);
    if (rooms != null) {
      hotelroomimage.value = rooms.roomImages;
    } else {
      hotelroomimage.clear(); 
    }
  }

  void _saveHotelsLocally(List<HotelsModel> hotels) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> hotelJsonList =
        hotels.map((hotel) => json.encode(hotel.toJson())).toList();
    prefs.setStringList('hotels', hotelJsonList);
  }

  // دالة لتحميل البيانات المخزنة من SharedPreferences
  Future<List<HotelsModel>> _getHotelsLocally() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? hotelJsonList = prefs.getStringList('hotels');
    if (hotelJsonList != null) {
      return hotelJsonList
          .map((jsonStr) => HotelsModel.fromJson(json.decode(jsonStr)))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> favorite(int id,context) async {
    try {
      bool success = await FavouritesService().addToFavourites(id);

      Get.find<FavouritesController>().fetchFavourites();

      if (success) {
        showFlushbarMessage(
          context,
          " success ",
          "successfull to add to favroute.",
          Colors.red,
        );
      } else {

         showFlushbarMessage(
          context,
          " Unsuccess ",
          "Unsuccessfull to add to favroute.",
          Colors.red,
        );
      }
    } catch (e) {
      print(" Unsuccessfull to add to favroute call the engireening $e");
      showFlushbarMessage(
          context,
          " Unsuccess ",
          "successfull to add to favroute,communaction with  ",
          Colors.red,
        );
    }
  }



  
}

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
import 'package:hotels/GTX/services/getAllCategories.dart';
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
  var reviewHotel = <ReviewModel>[].obs;
  var Servicehotel = <ModelService>[].obs;

  var hotel_name = "".obs;
 
  var image_hotel = "".obs;
  var room_name = "".obs;
  var hotelroomService = <modelServiceModel>[].obs;
  var selectedExtraServices = <int>[].obs;
  var hotelroomimage = <modelRoomImagee>[].obs;
  var isFetching = false.obs;
  var isFavorite = false.obs;

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  @override
  void onInit() {
    super.onInit();
    // toggleFavorite();
    fetchHotels();
  }
  

  void fetchHotels() async {
    isFetching.value = true;
    try {
      List<HotelsModel> fetchedHotels = await GetAllHotels().getAllHotels();
      hotelsList.value = fetchedHotels;
    } catch (e) {
      print("Error fetching data: $e");
      hotelsList.clear();
    } finally {
      isFetching.value = false;
    }
    update();
  }

  void loadHotelRoomsById(int hotelId) {
    final hotel = hotelsList.firstWhereOrNull((h) => h.id == hotelId);

    if (hotel != null) {
      hotel_name.value = hotel.name;
      image_hotel.value = hotel.image;
      hotelroom.value = hotel.rooms;
      // for (var element in hotelroom) {
      //   print(element);
        
      // }

      
      reviewHotel.value = hotel.reviews;
      Servicehotel.value = hotel.services;
    } else {
      hotelroom.clear();
      reviewHotel.clear();
      Servicehotel.clear();
    }
  }

  // void loadHotelreviewHotelById(int hotelId) {
  //   final hotel = hotelsList.firstWhereOrNull((h) => h.id == hotelId);
  //   if (hotel != null) {
  //     image_hotel.value = hotel.image;
  //     reviewHotel.value = hotel.reviews;

  //       reviewHotel.forEach((room) {
  //     print("معرف : ${room.id}");
  //     print("اسم : ${room.ratingCleanliness}");
  //     print("السعة : ${room.ratingService}");
  //     print("السعر : ${room.ratingLocation}");
  //     print("----");
  //   });
  //   } else {
  //     reviewHotel.clear();
  //   }
  // }

  void loadHotelRoomsServiceById(int room_id) {
    final rooms = hotelroom.firstWhereOrNull((h) => h.id == room_id);
    if (rooms != null) {
      room_name.value = rooms.name;
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

  Future<void> favorite(int id, context) async {
    for (var element in Get.find<FavouritesController>().favourites) {
      if (id == element.id) {
        Get.snackbar("ياراجل", "لقد اضفت هذا الفندق بالفعل!",
            backgroundColor: Colors.deepOrange);
        return;
      }
    }

    try {
      bool success = await FavouritesService().addToFavourites(id);

      Get.find<FavouritesController>().fetchFavourites();

      if (success) {
        Get.snackbar("تهانينا", "تم الاضافه للمفضله بنجاح!",
            backgroundColor: Colors.green);
      }
    } catch (e) {
      print("Failed to add to favourites: $e");

      Get.snackbar("مع الاسم",
          "لم يتم الاضفافه",
          backgroundColor: Colors.red);
    }
  }
}

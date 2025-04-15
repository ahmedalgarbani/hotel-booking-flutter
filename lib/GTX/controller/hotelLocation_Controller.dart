import 'package:get/get.dart';
import 'package:hotels/GTX/Models/LocationService.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/services/show_hotel_services.dart';

import 'package:get/get.dart';
import 'package:hotels/GTX/Models/LocationService.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/services/show_hotel_services.dart';

class HotelsController extends GetxController {
  var hotelsList = <HotelsModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHotelsByLocation();
  }

  String cleanCity(String city) {
    return city.replaceAll(RegExp(r'[\u200E\u200F\u202A-\u202E]'), '').trim();
  }

  void fetchHotelsByLocation() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      String city = await LocationService().getCurrentCity();
      city = cleanCity(city); 

      // if (city.isEmpty || city == "غير معروف") {
      //   errorMessage.value = "لم يتم تحديد المدينة بشكل صحيح";
      // } else {
      //   print(" المدينة المحددة: $city");
      // }

      List<HotelsModel> hotels = await GetAllHotelsSearch().getAllHotels(
        nameHotelSearch: "",
        locationHotelSearch: city,
        adult_number: 0, room_number: 0, check_in: '', check_out: '',
      );

      print("Fetched hotels: $hotels");
      hotelsList.value = hotels;

      if (hotels.isEmpty) {
        errorMessage.value = "no hotel in your city";
      }
    } catch (e) {
      errorMessage.value = "wrong when fetch hotel ${e.toString()}";
      print("Error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}


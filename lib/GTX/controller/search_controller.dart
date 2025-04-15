import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import '../services/show_hotel_services.dart';

class SearchHotelController extends GetxController {
  var hotels = <HotelsModel>[].obs;
  var isLoading = false.obs;
  var countersroom = 0.obs; 
  var counterQuest = 0.obs; 
  var check_out_date = "".obs;
  var check_in_date = "".obs;


  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController adultNumberController = TextEditingController();

  void increament() {
    countersroom++;
  }

  void decrementCounter() {
    if (countersroom > 1) countersroom--;
  }

  void incrementCounterQuests() {
    counterQuest++;
  }

  void decrementCounterQuests() {
    if (counterQuest > 1) counterQuest--;
  }

void prinsearch(){
   print("countersroom");
   print(countersroom);
  print("counterQuest");
  print(counterQuest);
  print("check_in_date");
  print(check_in_date);
  print("check_out_date");
  print(check_out_date);
  print("locationController");
  print(locationController.text);
  print("nameController");
  print(nameController.text);
}

    Future<void> searchHotelss() async {
 print("countersroom");
   print(countersroom);
  print("counterQuest");
  print(counterQuest);
  print("check_in_date");
  print(check_in_date);
  print("check_out_date");
  print(check_out_date);
  print("locationController");
  print(locationController.text);
  print("nameController");
  print(nameController.text);
    try {
      isLoading.value = true;
      hotels.value = await GetAllHotelsSearch().getAllHotels(
        nameHotelSearch: nameController.text,
        locationHotelSearch: locationController.text,
        adult_number: counterQuest.value, room_number: countersroom.value, check_in: check_in_date.value, check_out: check_out_date.value,
      );
    } catch (e) {
      print(" Error during search: $e");
    } finally {
      isLoading.value = false;
    }
  }





   Future<void> selectSearchDateRange(BuildContext context) async {
    isLoading.value = true;
    isLoading.value = false;
 

    final DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      barrierColor: Color.fromRGBO(21, 37, 65, 1),
      firstDate: DateTime(2025, 1, 1),
      lastDate: DateTime(2026, 1, 1),
      currentDate: DateTime.now(),
      saveText: 'Save',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(220, 7, 86, 152),
              onPrimary: Colors.white,
              onSurface: Color.fromRGBO(21, 37, 65, 1),
              primaryContainer: Colors.blue,
              secondaryContainer: const Color.fromARGB(255, 167, 171, 174),
              secondary: Colors.blue,
              inversePrimary: Colors.blue,
              tertiaryContainer: Colors.blue,
              onPrimaryFixedVariant: Colors.blue,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDateRange != null) {
      check_in_date.value =
          "${pickedDateRange.start.year}-${pickedDateRange.start.month.toString().padLeft(2, '0')}-${pickedDateRange.start.day.toString().padLeft(2, '0')} ";
      check_out_date.value =
          "${pickedDateRange.end.year}-${pickedDateRange.end.month.toString().padLeft(2, '0')}-${pickedDateRange.end.day.toString().padLeft(2, '0')}";
    }
  }




  
}

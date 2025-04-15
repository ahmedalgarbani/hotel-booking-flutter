import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/Booking_details_Controller.dart';
import 'package:hotels/GTX/controller/flashbar.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/services/BookingService.dart';
import 'package:hotels/GTX/views/screens/exchange.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class ConfirmController extends GetxController {
  final Hotelinfo hotelroomidList = Get.put(Hotelinfo());
  var isLoading = false.obs;


  final ImagePicker _picker = ImagePicker();
  var pickedimage = Rxn<File>();
  Future<void> fetchImageDialog() async {
    Get.defaultDialog(
      title: "Select Photo",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      content: Column(
        children: [
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.camera_alt, color: Colors.blue),
            title: const Text('Select From Camara'),
            onTap: () {
              Get.back();
              pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.green),
            title: const Text('Select From Gerary'),
            onTap: () {
              Get.back();
              pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
      radius: 10,
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) return;

    pickedimage.value = File(image.path);

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              pickedimage.value!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 5));
    // Get.back();
  }

//   Future<void> pickImage(ImageSource source) async {
//     final XFile? image = await _picker.pickImage(source: source);
//     if (image == null) return;

// pickedimage.value = File(image.path);
//     update();
//   }

  var bookingData = <String, dynamic>{}.obs;

  var booking_id = 0.obs;
  var hotel_name = "".obs;
  var room_name = "".obs;
  var room_id = "".obs;
  var hotel_id = "".obs;
  var rooms_booked = "".obs;
  var amount = "".obs;
  var check_out_date = "".obs;
  var check_in_date = "".obs;
  var additional_fee ="0".obs;
  var price ="0".obs;

  RxInt counters = 0.obs;
  RxInt counter = 0.obs;
  RxInt counterQuest = 0.obs;

  double get totalpriceSubtotal {
    final price = double.tryParse(amount.value) ?? 0;
    return price * counters.value;
  }
  double get totalPrice {

    final priceSubtotal = double.tryParse(additional_fee.value) ?? 0;
    final price = double.tryParse(amount.value) ?? 0;
    return price * counters.value + priceSubtotal ;
  }

  void increament() {
    counters.value++;
    rooms_booked.value = counter.toString();
  }

  void decrementCounter() {
    if (counters > 0) counters--;
  }

  void incrementCounterQuests() {
    counterQuest++;
  }

  void decrementCounterQuests() {
    if (counterQuest > 0) counterQuest--;
  }

  void updateHotelAndRoomNames() {
    hotel_name.value = hotelroomidList.hotel_name.value;
    room_name.value = hotelroomidList.room_name.value;
  }
//   void fetchHotelRoomName({required String hotelname,required String roomName}) {
//    hotel_name.value = hotelname;
//    room_name.value = roomName;
//    print("{hotelnameroom_name}");
//    print("{hotelnameroom_name}");
//    print("{hotelnameroom_name}");
//    print("${hotelname} + ${room_name}");
//    print("{hotelnameroom_name}");
// }

  final BookingController bookingController = Get.find<BookingController>();

  Future<void> makeBooking({
    required BuildContext context,
    required int hotelId,
    required int roomId,
    required String checkInDate,
    required String checkOutDate,
    required double amount,
    required int roomsBooked,
  }) async {
    if (check_in_date.value.isEmpty || check_out_date.value.isEmpty) {
      if (!Get.isSnackbarOpen) {
        showFlushbarMessage(
          context,
          "Please select dates",
          "You must select a check-in and check-out date.",
          Colors.red,
        );
      }
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      showFlushbarMessage(
        context,
        "Not Logged In",
        "Please log in to continue.",
        Colors.red,
      );
      return;
    }

    try {
      isLoading.value = true;
      Map<String, dynamic>? response = await BookingService().createBooking(
        hotelId: hotelId,
        roomId: roomId,
        checkInDate: checkInDate.trim(),
        checkOutDate: checkOutDate.trim(),
        amount: amount,
        roomsBooked: roomsBooked,
      );

      if (response != null) {
        bookingData.assignAll(response);

        print("boooooookinggggggggggggg id ");

        print(response['id']);
        booking_id.value = response['id'];

        showFlushbarMessage(
          context,
          "Booking Successful",
          "Your booking was successfully completed.",
          Colors.green,
        );
        bookingController.fetchBookings();

        Get.to(() => ExchangeApp(indexhotel: hotelId));

        check_in_date.value = "";
        check_out_date.value = "";
      } else {
        throw Exception('No response from server');
      }
    } catch (e) {
      print("❌ فشل الحجز: $e");
      showFlushbarMessage(
        context,
        "Booking Failed",
        "There was an error while making the booking.",
        Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateConfirmBooking(
      {required final int indexhotel, required final int indexroom}) async {
    isLoading.value = true;
    hotel_id.value = hotelroomidList.hotelsList[indexhotel].id.toString();
    room_id.value =
        hotelroomidList.hotelsList[indexhotel].rooms[indexroom].id.toString();
    amount.value = hotelroomidList
        .hotelsList[indexhotel].rooms[indexroom].basePrice
        .toString();

    // // تنفيذ الحجز (محاكاة)
    // await Future.delayed(Duration(seconds: 2));

    isLoading.value = false;
  }

  Future<void> selectDateRange(BuildContext context) async {
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

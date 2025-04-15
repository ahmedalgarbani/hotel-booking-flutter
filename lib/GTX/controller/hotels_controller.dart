// import 'package:get/get.dart';
// import 'package:hotels/GTX/Models/show_hotel_model.dart';
// import 'package:hotels/GTX/services/show_hotel_services.dart';

// class HotelsController extends GetxController {
//   var hotelsList = <HotelsModel>[].obs;
//   var isLoading = true.obs;
//   var errorMessage = "".obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchHotels();
//   }

//   void fetchHotels() async {
//     try {
//       isLoading(true);
//       var hotels = await GetAllHotelsLocation().getAllHotelsByLocation();
//       hotelsList.assignAll(hotels);
//     } catch (e) {
//       errorMessage.value = e.toString();
//     } finally {
//       isLoading(false);
//     }
//   }
// }

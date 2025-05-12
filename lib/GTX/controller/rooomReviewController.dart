// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hotels/GTX/Models/hotel_review_model.dart';
// import 'package:hotels/GTX/services/hotel_review_service.dart';
// import 'package:hotels/GTX/services/rievewRoom.dart';

// class Rooomreviewdetailcontroller extends GetxController {
//   final reviewTextController = TextEditingController();
//   final rating = 0.obs;

//   final isLoading = false.obs;

//   HotelReviewModel? reviewModel;

//   Future<void> submitReview({
//     required int hotelId,
//     required int roomTypeId,
//   }) async {
//     isLoading.value = true;

//     try {
//       HotelReviewModel result = await Rievewroom().makeReviewRoom(
//         hotel: hotelId,
//         roomType: roomTypeId,
//         rating: rating.value,
//         review: reviewTextController.text,
//       );
//       reviewModel = result;
//       Get.snackbar("تم التقييم", "شكراً على تقييمك");
//     } catch (e) {
//       Get.snackbar("خطأ", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   @override
//   void onClose() {
//     reviewTextController.dispose();
//     super.onClose();
//   }
// }

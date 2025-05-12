import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/RoomReviewModel.dart';
import 'package:hotels/GTX/Models/hotel_review_model.dart';
import 'package:hotels/GTX/services/hotel_review_service.dart';
import 'package:hotels/GTX/services/rievewRoom.dart';

class RievewrroomdetailController extends GetxController {
  TextEditingController reviewTextController = TextEditingController();
  final rating = 0.obs;

  final isLoading = false.obs;

  RoomReviewModel? reviewModel;

  Future<void> submitReview({
    required int hotelId,
    required int roomTypeId,
  }) async {
    isLoading.value = true;

    print(hotelId);
    print(hotelId);
    print(roomTypeId);
    try {
      RoomReviewModel result = await Rievewroom().makeReviewRoom(
        hotel: hotelId,
        roomType: roomTypeId,
        rating: rating.value,
        review: reviewTextController.text,
      );
      reviewModel = result;
      reviewTextController.text = '';
      rating.value = 0;
      Get.snackbar("تم التقييم", "شكراً على تقييمك");
      reviewTextController;
    } catch (e) {
      // Get.snackbar("خطأ", e.toString());
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    reviewTextController.dispose();
    super.onClose();
  }
}

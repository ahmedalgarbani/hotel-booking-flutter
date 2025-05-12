import 'package:get/get.dart';
import 'package:hotels/GTX/services/hotel_review_service.dart';

class HotelReviewController extends GetxController {
  var isSubmitting = false.obs;
  var reviewStatus = "".obs;
  var review = "".obs;

  var ratingService = 0.obs;
  var ratingLocation = 0.obs;
  var ratingValueForMoney = 0.obs;
  var ratingCleanliness = 0.obs;

  void setReview(String text) {
    review.value = text;
  }

  void setRating(String category, int value) {
    switch (category) {
      case "الخدمة":
        ratingService.value = value;
        break;
      case "النظافة":
        ratingCleanliness.value = value;
        break;
      case "الموقع":
        ratingLocation.value = value;
        break;
      case "السعر":
        ratingValueForMoney.value = value;
        break;
    }
  }

  Future<void> submitHotelReview({
    required int hotel,
    required String review,
  }) async {
    isSubmitting.value = true;

    try {

      print(hotel);
      print(review);
      print(ratingService.value);
      print(ratingLocation.value);
      print(ratingValueForMoney.value);
      print(ratingCleanliness.value);
      await HotelReviewService().makeReviewHotel(
        hotel: hotel,
        ratingService: ratingService.value,
        ratingLocation: ratingLocation.value,
        ratingValueForMoney: ratingValueForMoney.value,
        ratingCleanliness: ratingCleanliness.value,
        review: review,
      );
      reviewStatus.value = "تم إرسال التقييم بنجاح!";
    } catch (e) {
      reviewStatus.value = "حدث خطأ أثناء إرسال التقييم: $e";
      // Get.snackbar("title", "message");
    } finally {
      isSubmitting.value = false;
    }
  }
}

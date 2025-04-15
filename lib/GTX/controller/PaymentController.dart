import 'dart:io';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/PaymentModel.dart';
import 'package:hotels/GTX/services/postPaymentModel.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;
  var paymentResult = Rxn<PaymentModel>();
  var errorMessage = ''.obs;

  Future<void> makePayment({
    required int bookingId,
    required int paymentMethodId,
    required double paymentSubtotal,
    required double paymentTotalAmount,
    required String paymentCurrency,
    required String paymentType,
    required File transferImage,
    required String? paymentNote,
    required String paymentDiscount,
    required int paymentStatus,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await Postpaymentmodel().makePayment(
        bookingId: bookingId,
        paymentMethodId: paymentMethodId,
        paymentSubtotal: paymentSubtotal,
        paymentTotalAmount: paymentTotalAmount,
        paymentCurrency: paymentCurrency,
        paymentType: paymentType,
        transferImage: transferImage,
        paymentNote: paymentNote,
        paymentDiscount: paymentDiscount,
        paymentStatus: paymentStatus,
      );
      paymentResult.value = result;

      if (result != null) {
        Get.snackbar("نجاح", "تم الدفع بنجاح");
      }
    } catch (e) {
      errorMessage.value = "فشلت عملية الدفع: $e";
      print(e);

      Get.snackbar("خطأ", errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}


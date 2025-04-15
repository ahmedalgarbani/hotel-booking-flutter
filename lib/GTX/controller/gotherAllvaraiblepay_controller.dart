import 'dart:io';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/PaymentOption_model.dart';
import 'package:hotels/GTX/controller/PaymentController.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/controller/paymentOption_Cotroller.dart';
import 'package:hotels/GTX/services/BookingService.dart';
import 'package:hotels/GTX/services/show_payment_option_service.dart';

class GotherallvaraiblepayController extends GetxController {
  RxInt bookingId = 0.obs;
  RxInt paymentMethodId = 0.obs;
  var paymentSubtotal = ''.obs;
  var paymentTotalAmount = ''.obs;
  var paymentType = ''.obs;
  var transferImage = Rxn<File>();
  var paymentNote = ''.obs;
  var paymentDiscount = '0'.obs;
  var paymentStatus = ''.obs;
    var selectedCurrency = ''.obs;


  // final PaymentController findhpaymrnt = Get.find<PaymentController>();
  final ConfirmController confirmController = Get.find<ConfirmController>();
  final PaymentOptionController paymentOptionController =
      Get.find<PaymentOptionController>();

  Future<void> printallVaribale() async {
  bookingId.value = confirmController.booking_id.value;
  paymentSubtotal.value = confirmController.totalpriceSubtotal.toString();
  paymentTotalAmount.value = confirmController.totalPrice.toString();
  transferImage.value = confirmController.pickedimage.value;
  // selectedCurrency.value=paymentOptionController.selectedCurrency.value;

  print("''''''''''''''''''''''''''''''''''''''''''''");
  print("bookingId ${bookingId.value}");
  print("paymentMethodIdkkkkkkkkkk ${paymentMethodId.value}");
  print("paymentSubtotal ${paymentSubtotal.value}");
  print("paymentTotalAmount ${paymentTotalAmount.value}");
  print("transferImage ${transferImage.value}");
  print("selectedCurrency ${selectedCurrency.value}");
}

}

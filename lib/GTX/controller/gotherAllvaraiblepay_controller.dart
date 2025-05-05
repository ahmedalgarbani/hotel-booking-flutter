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
  var transferImage = Rxn<File>();
  var paymentNote = ''.obs;
  var paymentDiscount = '0'.obs;
  var paymentStatus = ''.obs;
  var selectedCurrency = ''.obs;
  var paymentType = 'cash'.obs;
  var check_out_date = "".obs;
  var check_in_date = "".obs;
 

  // final PaymentController findhpaymrnt = Get.find<PaymentController>();
  final ConfirmController confirmController = Get.find<ConfirmController>();
  final PaymentOptionController paymentOptionController =
      Get.find<PaymentOptionController>();

  Future<void> printallVaribale() async {
    bookingId.value = confirmController.booking_id.value;
    paymentSubtotal.value = confirmController.totalpriceSubtotal.toString();
    paymentTotalAmount.value = confirmController.totalPrice.toString();
    transferImage.value = confirmController.pickedimage.value;
    check_in_date.value = confirmController.check_in_date.value;
    check_out_date.value = confirmController.check_out_date.value;
    // selectedCurrency.value=paymentOptionController.selectedCurrency.value;

    print("''''''''''''''''''''''''''''''''''''''''''''");
    print("bookingId ${bookingId.value}");
    print("paymentMethodIdkkkkkkkkkk ${paymentMethodId.value}");
    print("paymentSubtotal ${paymentSubtotal.value}");
    print("paymentTotalAmount ${paymentTotalAmount.value}");
    print("transferImage ${transferImage.value}");
    print("selectedCurrency ${selectedCurrency.value}");
    print("check_out_date ${check_out_date.value}");
    print("check_in_date ${check_in_date.value}");
  }
}

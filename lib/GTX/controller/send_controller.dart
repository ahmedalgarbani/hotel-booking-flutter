import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/otp_controller.dart';
import 'package:hotels/GTX/services/sendsms_service.dart';
import 'package:hotels/GTX/views/screens/CheckCodeScreen/CheckCodeScreen.dart';

class SendController extends GetxController {
  final phoneController = TextEditingController().obs;
  final SendsmsService _otpService = SendsmsService();


  Future<void> sendOTP() async {
    final phone = phoneController.value.text;
    print("phone");
    print(phone);

    if (phoneController.value.text.isEmpty) {
      Get.snackbar("Error", "Please enter a valid phone number");
      return;
    }

    final isSent = await _otpService.sendOTP(phone);
    if (isSent) {
      _clearFields();
      
      Get.to(() => CheckCodeScreen());
    }
  }

  void _clearFields() {
    phoneController.value.clear();
  }

  @override
  void onClose() {
    phoneController.value.dispose();

    super.onClose();
  }
}

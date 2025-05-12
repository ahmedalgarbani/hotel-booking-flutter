import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hotels/GTX/controller/Register_Controll.dart';
import 'package:hotels/GTX/views/screens/mainpagescreens/homepage.dart';

import '../services/OTPService.dart';

class OTPController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final OTPService _otpService = OTPService();
    final registrationController = Get.find<RegistrationController>();


  Future<void> verifyCode() async {
    final phone = phoneController.text;
    final code = codeController.text;
    print(phone);
    print(code);

    if (phone.isEmpty || code.length < 6) {

      Get.snackbar("خطأ", "يرجى إدخال رقم الهاتف والكود الكامل");
      return;
    }

    final isVerified = await _otpService.checkOTP(phone, code);
    if (isVerified) {
      _clearFields();
      registrationController.register();
      Get.offAll(() => Homepage());
      Get.snackbar("تم", "تم التحقق بنجاح!");
    }
  }

  void _clearFields() {
    phoneController.clear();
    codeController.clear();
  }

  @override
  void onClose() {
    phoneController.dispose();
    codeController.dispose();
    super.onClose();
  }
}

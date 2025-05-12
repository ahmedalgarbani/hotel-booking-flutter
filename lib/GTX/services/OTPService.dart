import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:hotels/GTX/helper/api.dart';
import 'package:http/http.dart' as http;

class OTPService {
 

  Future<bool> checkOTP(String phoneNumber, String otpCode) async {
    final url = 'http://192.168.8.115:8000/api/check-otp/';
     
     print("otpCode");
     print(otpCode);
     print("phoneNumber");
     print(phoneNumber);
    try {
      final response = await Api().post(
        url: url,
        body: {
          'phone_number': phoneNumber,
          'otp_code': otpCode
        },
      );

      if (response != null && response['success'] == true) {
        return true;
      } else {
        Get.snackbar("خطأ", response['message'] ?? "فشل التحقق من الكود.");
      }
    } catch (e) {
      Get.snackbar("خطأ", "فشل الاتصال بالخادم: $e");
    }

    return false;
  }
}

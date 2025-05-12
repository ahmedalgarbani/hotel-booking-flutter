import 'dart:convert';
import 'package:get/get.dart';
import 'package:hotels/GTX/views/screens/mainpagescreens/homepage.dart';
import 'package:hotels/GTX/helper/api.dart';  

class SendsmsService {
  Future<bool> sendOTP(String phoneNumber) async {
    final url = 'http://192.168.8.115:8000/api/send-sms/'; 

    try {
      final response = await Api().post(
        url: url,
        body: {'phone_number': phoneNumber}, 
      );

      if (response != null && response['success'] == true) {
        Get.snackbar("Success", "OTP sent successfully!");
          
        return true;
      } else {
        Get.snackbar("Error", response['message'] ?? "Failed to send OTP. Please try again.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to connect to server: $e");
    }

    return false;
  }
}

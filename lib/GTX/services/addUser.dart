import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/Models/rigetermodel.dart';
import 'package:hotels/GTX/helper/api.dart';
  import 'package:http/http.dart' as http;


class AddUser  {

  
  Future<Rigetermodel> addUser({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String birth_date,
    required String phone,
    required String gender,
    required File? image,
  }) async {

   
    

    Map<String, dynamic> data = await Api().post(
      url: 'http://192.168.8.115:8000/api/register/',
      body: {
        'username': username,
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'gender': gender,
        'birth_date': birth_date,
      },
      image: image,
    );

    return Rigetermodel.fromJson(data);
  }




// Future<void> sendOTP(String phoneNumber) async {
//   final url = 'http://192.168.8.115:8000/api/send-sms/'; 
//   final response = await http.post(
//     Uri.parse(url),
//     body: jsonEncode({'phone_number': phoneNumber}),
//     headers: {
//       'Content-Type': 'application/json',
//     },
//   );

//   if (response.statusCode == 200) {
//     final responseData = jsonDecode(response.body);
//     if (responseData['success']) {
//       Get.snackbar("Success", "OTP sent successfully!");
//     } else {
//       Get.snackbar("Error", "Failed to send OTP. Please try again.");
//     }
//   } else {
//     Get.snackbar("Error", "An error occurred while sending OTP.");
//   }
// }



}

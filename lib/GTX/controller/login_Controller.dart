import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hotels/GTX/Models/login_Model.dart';
import 'package:hotels/GTX/helper/api.dart';
import 'package:hotels/GTX/services/login.dart';
import 'package:hotels/GTX/views/screens/mainpagescreens/homepage.dart';

class SignupController extends GetxController {
  var isLoading = false.obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var profileData = <String, dynamic>{}.obs;

  Future<void> signup() async {
    isLoading.value = true;

    if (emailController.value.text.isEmpty ||
        passwordController.value.text.isEmpty) {
      Get.snackbar("Error", "Please fill in all the fields",
          backgroundColor: Colors.deepOrangeAccent);
      isLoading.value = false;
      return;
    }

    try {
      final success = await LoginService().loginUser(
        email: emailController.value.text,
        password: passwordController.value.text,
      );

      if (success != null) {
        profileData.value = success.toJson();
        print(profileData['id']);
        print("username========================");
        print(profileData['username']);

        _clearFields();
        Get.snackbar("Success", "User Login successfully!",backgroundColor: Colors.green);
        print("Login Success: $success");

        Get.offAll(Homepage());
      } else {
        Get.snackbar("Error", "Failed to log in");
      }
    } catch (e) {
      print("Error registering user: $e");
      Get.snackbar(
        "Error",
        "uncorrect passworld or Email.".tr
        ,backgroundColor: Colors.deepOrangeAccent
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _clearFields() {
    emailController.value.clear();
    passwordController.value.clear();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.value.dispose();
    passwordController.value.dispose();
  }
}

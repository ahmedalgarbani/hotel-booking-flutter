import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/services/addUser.dart';
class RegistrationController extends GetxController {
  var usernameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var personImage = Rxn<File>();
final ConfirmController confirmController=Get.find<ConfirmController>();

  Future<void> register() async {
    if (usernameController.value.text.isEmpty || 
        emailController.value.text.isEmpty || 
        firstNameController.value.text.isEmpty || 
        lastNameController.value.text.isEmpty || 
        phoneController.value.text.isEmpty || 
        passwordController.value.text.isEmpty) {
      Get.snackbar("Error", "Please fill in all the fields");
      return; 
    }

    try {
      final user = await AddUser().addUser(
        username: usernameController.value.text,
        email: emailController.value.text,
        firstName: firstNameController.value.text,
        lastName: lastNameController.value.text,
        phone: phoneController.value.text,
        password: passwordController.value.text, 
         image: confirmController.pickedimage.value!,
      );

      _clearFields();
      Get.snackbar("Success", "User created successfully!");
    } catch (e) {
      print("Error registering user: $e");
      Get.snackbar("Error", "An error occurred during registration.");
    }
  }

  void _clearFields() {
    usernameController.value.clear();
    emailController.value.clear();
    passwordController.value.clear();
    firstNameController.value.clear();
    lastNameController.value.clear();
    phoneController.value.clear();
  }

  @override
  void onClose() {
    super.onClose();
    usernameController.value.dispose();
    emailController.value.dispose();
    passwordController.value.dispose();
    firstNameController.value.dispose();
    lastNameController.value.dispose();
    phoneController.value.dispose();
  }
}





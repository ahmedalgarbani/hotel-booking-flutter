import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/services/addUser.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationController extends GetxController {
  var usernameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var birthDateController = TextEditingController().obs;

  var gender = 'male'.obs;
  final ImagePicker _picker = ImagePicker();
  var profileimage = Rxn<File>();
  final ConfirmController confirmController = Get.find<ConfirmController>();

 Future<void> register() async {
  if (usernameController.value.text.isEmpty ||
      emailController.value.text.isEmpty ||
      firstNameController.value.text.isEmpty ||
      lastNameController.value.text.isEmpty ||
      phoneController.value.text.isEmpty ||
      passwordController.value.text.isEmpty ||
      birthDateController.value.text.isEmpty) {
    Get.snackbar("Error", "Please fill in all the fields");
    return;
  }

  RegExp emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
  if (!emailRegex.hasMatch(emailController.value.text)) {
    Get.snackbar("Error", "Please enter a valid email address");
    return;
  }

  RegExp phoneRegex = RegExp(r"^\d{9,15}$");
  if (!phoneRegex.hasMatch(phoneController.value.text)) {
    Get.snackbar("Error", "Phone number must be between 9 and 15 digits");
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
      image: profileimage.value,
      gender: gender.value,
      birth_date: birthDateController.value.text,
    );

     _clearFields();
  Get.snackbar("Success", "User created successfully!".tr,);
} catch (e) {
  print("Error registering user: $e");

  if (e.toString().contains("A user with that username already exists.")) {
    Get.snackbar("Error", "Username already exists, please choose another.",backgroundColor: Colors.deepOrangeAccent);
  } else if (e.toString().contains("Enter a valid email address.")) {
    Get.snackbar("Error", "Please enter a valid email address.",backgroundColor: Colors.deepOrangeAccent);
  } else {
    Get.snackbar("Error", "Username already exists, please choose another.",backgroundColor: Colors.deepOrangeAccent);
  }
}
}


  void _clearFields() {
    usernameController.value.clear();
    emailController.value.clear();
    passwordController.value.clear();
    firstNameController.value.clear();
    lastNameController.value.clear();
    phoneController.value.clear();
    profileimage.value = null;
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

  Future<void> profileImageDialog() async {
    Get.defaultDialog(
      title: "Select Photo",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      content: Column(
        children: [
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.camera_alt, color: Colors.blue),
            title: const Text('Select From Camara'),
            onTap: () {
              Get.back();
              pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.green),
            title: const Text('Select From Gerary'),
            onTap: () {
              Get.back();
              pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
      radius: 10,
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) return;

    profileimage.value = File(image.path);

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              profileimage.value!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 5));
    // Get.back();
  }
}

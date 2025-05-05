import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hotels/GTX/Models/rigetermodel.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/services/addUser.dart';
import 'package:hotels/GTX/services/updateuser.dart';
import 'package:image_picker/image_picker.dart';

class Updateprofilecontroller extends GetxController {
  var usernameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var birthDateController = TextEditingController().obs;
  var user = Rxn<Rigetermodel>();

  final ImagePicker _picker = ImagePicker();
  var updatepickedimage = Rxn<File>();
  var selectedGender = 'male'.obs;

  @override
  void onInit() {
    super.onInit();
    // print("Received user: ${user.username}");
    // fetchupdate(user:user.value);
  }
// final ConfirmController confirmController=Get.find<ConfirmController>();

  void fetchupdate({required Rigetermodel user}) {
     this.user.value = user;
    usernameController.value.text = user.username;
    firstNameController.value.text = user.firstName;
    lastNameController.value.text = user.lastName;
    phoneController.value.text = user.phone;
    passwordController.value.text = user.password.toString();
    emailController.value.text = user.email;
    birthDateController.value.text = user.birth_date;
    selectedGender.value = user.gender;
    updatepickedimage.value = File(user.image!);
  }

  Future<void> Updateuserpro() async {
    

    try {
      final user = await Updateuser().updateProfile(
        username: usernameController.value.text,
        email: emailController.value.text,
        firstName: firstNameController.value.text,
        lastName: lastNameController.value.text,
        phone: phoneController.value.text,
        password: passwordController.value.text,
        image: updatepickedimage.value,
        selectedGender: selectedGender.value,
        birth_date: birthDateController.value.text,
      );
      print("birthDateController.text");
      print("birthDateController.text");
      print("birthDateController.text");
      print(birthDateController.value.text);
      print(selectedGender.value);
      _clearFields();
      Get.snackbar("Success", "User created successfully!",backgroundColor: Colors.green);
    } catch (e) {
      print("Error registering user: $e");
      // Get.snackbar("Error", "An error occurred during registration.");
    }
  }

  void _clearFields() {
    usernameController.value.clear();
    emailController.value.clear();
    passwordController.value.clear();
    firstNameController.value.clear();
    lastNameController.value.clear();
    phoneController.value.clear();
    updatepickedimage.value = null;
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

  Future<void> updateImageDialog() async {
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

    updatepickedimage.value = File(image.path);

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              updatepickedimage.value!,
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

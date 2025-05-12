import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/GuestModel.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/services/addGuestServer.dart';
import 'package:image_picker/image_picker.dart';

class GuestController extends GetxController {
  var usernameController = TextEditingController().obs;
 
  
  var phoneController = TextEditingController().obs;
  var birthDateController = TextEditingController().obs;
  var booking_id = 0.obs;

  var gender = 'male'.obs;
  final ImagePicker _picker = ImagePicker();
  var personalCard = Rxn<File>();

  void prontbookingid() {
    print(booking_id);
    print("booking_id");
    print("booking_id");
    print(booking_id);
  }

  Future<void> addGuessBooking() async {
    if (usernameController.value.text.isEmpty ||   
        phoneController.value.text.isEmpty ||
        personalCard.value==null ||
        gender.value.isEmpty ||
        birthDateController.value.text.isEmpty) {
      Get.snackbar("Error", "Please fill in all the fields");
      return;
    }

  
    RegExp phoneRegex = RegExp(r"^\d{9,15}$");
    if (!phoneRegex.hasMatch(phoneController.value.text)) {
      Get.snackbar("Error", "Phone number must be between 9 and 15 digits");
      return;
    }

    try {
      final user = await Addguestserver().addGues(
        name: usernameController.value.text,
        phone: phoneController.value.text,
        image: personalCard.value,
        gender: gender.value,
        birth_date: birthDateController.value.text,
        bookingid: booking_id.value,
      );

      _clearFields();
      Get.snackbar(
        "تم",
        "اضافة الزائر!".tr,
      );
    } catch (e) {
      print("Error registering user: $e");

      if (e.toString().contains("A user with that username already exists.")) {
        Get.snackbar("Error", "Username already exists, please choose another.",
            backgroundColor: Colors.deepOrangeAccent);
      } else if (e.toString().contains("Enter a valid email address.")) {
        Get.snackbar("Error", "Please enter a valid email address.",
            backgroundColor: Colors.deepOrangeAccent);
      } else {
        Get.snackbar("Error", "Username already exists, please choose another.",
            backgroundColor: Colors.deepOrangeAccent);
      }
    }
  }

  void _clearFields() {
    usernameController.value.clear();
  
    phoneController.value.clear();
    personalCard.value = null;
  }

  @override
  void onClose() {
    super.onClose();
    usernameController.value.dispose();
   
    phoneController.value.dispose();
  }

  Future<void> personalCardDialog() async {
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

    personalCard.value = File(image.path);

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              personalCard.value!,
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

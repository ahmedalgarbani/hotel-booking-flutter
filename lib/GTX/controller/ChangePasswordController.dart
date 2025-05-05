import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/services/changePWD.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> changePassword() async {
  isLoading.value = true;

  final oldPassword = oldPasswordController.text.trim();
  final newPassword = newPasswordController.text.trim();

  if (oldPassword.isEmpty || newPassword.isEmpty) {
    Get.snackbar('خطأ', 'يرجى إدخال كلمتي المرور');
    isLoading.value = false;
    return;
  }

  String? errorMessage = await ChangePasswordService().changePassword(
    oldPassword: oldPassword,
    newPassword: newPassword,
  );

  isLoading.value = false;

  if (errorMessage == null) {
    Get.snackbar('تم', 'تم تغيير كلمة المرور بنجاح',backgroundColor: Colors.green);
    oldPasswordController.clear();
    newPasswordController.clear();
  } else {
    Get.snackbar('خطأ', errorMessage,backgroundColor: Colors.red);
  }
}


  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/ChangePasswordController.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/views/widgets/ConnectionCheckWidget/ConnectionCheckWidget.dart';

class ChangePasswordPage extends StatelessWidget {
  final ChangePasswordController controller =
      Get.find<ChangePasswordController>();
  final NetworkController connectivityController =
      Get.find<NetworkController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!connectivityController.isConnected.value) {
        return ConnectionCheckWidget();
      }
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text('Change Password'.tr),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                color: Theme.of(context).colorScheme.secondary,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      Icon(Icons.lock, size: 60, color: Colors.blue.shade700),
                      SizedBox(height: 20),
                      Text(
                        "Update your password".tr,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),

                      // Current Password
                      TextField(
                        controller: controller.oldPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Current Password'.tr,
                          hintText: 'Enter your current password'.tr,
                          prefixIcon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      SizedBox(height: 20),

                      // New Password
                      TextField(
                        controller: controller.newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'New Password'.tr,
                          hintText: 'Enter your new password'.tr,
                          prefixIcon: Icon(Icons.lock_open),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Update Button
                      Obx(() => controller.isLoading.value
                          ? CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: controller.changePassword,
                                child: Text('Update Password'.tr),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 3,
                color: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children:  [
                      Row(
                        children: [
                          Icon(Icons.shield, color: Colors.blue),
                          SizedBox(width: 8),
                          Expanded(child: Text("Use at least 8 characters".tr)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.key, color: Colors.blue),
                          SizedBox(width: 8),
                          Expanded(child: Text("Mix letters and numbers".tr)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

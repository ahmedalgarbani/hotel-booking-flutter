import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/rigetermodel.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/controller/updateprofilecontroller.dart';
import 'package:hotels/GTX/views/widgets/ConnectionCheckWidget/ConnectionCheckWidget.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  // final Rigetermodel user;
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final Updateprofilecontroller controller =
      Get.find<Updateprofilecontroller>();
  final NetworkController connectivityController =
      Get.find<NetworkController>();

  final _formKey = GlobalKey<FormState>();

  // final TextEditingController _birthDateController = TextEditingController();
  // String selectedGender = 'male';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!connectivityController.isConnected.value) {
        return ConnectionCheckWidget();
      }
      return Scaffold(
        appBar: AppBar(
          title:  Text("Update Profile".tr,
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Obx(() {
                  return Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            
                            shape: BoxShape.circle,
                            border: Border.all( color: Theme.of(context).colorScheme.primary, width: 2),
                            image: controller.updatepickedimage.value != null
                                ? DecorationImage(
                                    image: FileImage(
                                        controller.updatepickedimage.value!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: controller.updatepickedimage.value == null
                              ? const Icon(Icons.person, size: 60)
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all( color: Theme.of(context).colorScheme.primary, width: 2),
                            ),
                            child: IconButton(
                              icon:  Icon(Icons.camera_alt,
                                   color: Theme.of(context).colorScheme.primary,),
                              onPressed: () {
                                controller.updateImageDialog();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 24),
                Obx(() => TextFormField(
                      controller: controller.usernameController.value,
                      decoration:
                          _buildInputDecoration("User Name".tr, Icons.person),
                    )),
                const SizedBox(height: 16),
                Obx(() => TextFormField(
                      controller: controller.emailController.value,
                      decoration: _buildInputDecoration(
                          "Email".tr, Icons.email),
                      keyboardType: TextInputType.emailAddress,
                    )),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => TextFormField(
                            controller: controller.firstNameController.value,
                            decoration: _buildInputDecoration(
                                "First Name", Icons.person_outline),
                          )),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Obx(() => TextFormField(
                            controller: controller.lastNameController.value,
                            decoration: _buildInputDecoration(
                                "Last Name".tr, Icons.person_outline),
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Obx(() => TextFormField(
                      controller: controller.phoneController.value,
                      decoration:
                          _buildInputDecoration("Phone Number".tr, Icons.phone),
                      keyboardType: TextInputType.phone,
                    )),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.birthDateController.value,
                  decoration: _buildInputDecoration(
                      "BrithDay".tr, Icons.calendar_today),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      controller.birthDateController.value.text =
                          DateFormat('yyyy-MM-dd').format(picked);
                    }
                  },
                ),
                Column(
                  children: [
                    GenderSelectionWidget(
                      setState: setState,
                      selectedGender: controller.selectedGender.value,
                      onGenderChanged: (val) {
                        setState(() {
                          controller.selectedGender.value = val!;
                          print(controller.selectedGender.value);
                          print(controller.selectedGender.value);
                          // registrationController.gender.value=selectedGender;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.Updateuserpro();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child:  Text("Save Changers".tr,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
     
    
    );
  }
}

Widget GenderSelectionWidget({
  required void Function(void Function()) setState,
  required String selectedGender,
  required Function(String?) onGenderChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       Text(
        "Choose Gender".tr,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Row(
        children: [
          Radio<String>(
            value: 'Male',
            groupValue: selectedGender,
            onChanged: onGenderChanged,
          ),
          const Text("Male"),
          Radio<String>(
            value: 'Female'.tr,
            groupValue: selectedGender,
            onChanged: onGenderChanged,
          ),
           Text('Female'.tr),
        ],
      ),
    ],
  );
}

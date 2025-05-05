import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/Register_Controll.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/views/widgets/registers/mainregisre.dart';
import 'package:intl/intl.dart';

class Registerwidget extends StatelessWidget {
  final registrationController = Get.find<RegistrationController>();
  final RxString selectedGender = 'Male'.obs;

  Registerwidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title:  Text("Register".tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: GetX<RegistrationController>(
          builder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2),
                          image:
                              registrationController.profileimage.value != null
                                  ? DecorationImage(
                                      image: FileImage(registrationController
                                          .profileimage.value!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                        ),
                        child: registrationController.profileimage.value == null
                            ? const Icon(Icons.person, size: 60)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () {
                              registrationController.profileImageDialog();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              _buildTextField(context, "User Name".tr, Icons.person,
               keyboardType: TextInputType.text,
                  registrationController.usernameController.value),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: _buildTextField(
                          context,
                          "First Name".tr,
                          Icons.person,
                                         keyboardType: TextInputType.text,

                          registrationController.firstNameController.value)),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _buildTextField(context, "Last Name".tr, Icons.person,
                       keyboardType: TextInputType.text,
                          registrationController.lastNameController.value)),
                ],
              ),
              const SizedBox(height: 10),
              _buildTextField(context, "Email".tr, Icons.email,
               keyboardType: TextInputType.emailAddress,
                  registrationController.emailController.value),
              const SizedBox(height: 10),
              _buildTextField(context, "Password".tr, Icons.lock,
                  registrationController.passwordController.value,
 keyboardType: TextInputType.visiblePassword,
                  obscureText: true),
              const SizedBox(height: 10),
              _buildTextField(context, "Phone".tr, Icons.phone,
                        keyboardType: TextInputType.phone,

                  registrationController.phoneController.value, ),
              const SizedBox(height: 10),
              _buildBirthDatePicker(context),
              const SizedBox(height: 10),
              _buildGenderSelection(),
              const SizedBox(height: 20),
            
                 ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: registrationController.register,
                  child:  Text("Register".tr),
                ),
           
              TextButton(
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                child:  Text("Already have an account? Login".tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String hint, IconData icon,
   

      TextEditingController controller,
      {bool obscureText = false,TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
              keyboardType: keyboardType, 

      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildBirthDatePicker(BuildContext context) {
    return TextField(
      controller: registrationController.birthDateController.value,
      decoration: InputDecoration(
        labelText: "Birth Date".tr,
        prefixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      readOnly: true,
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          registrationController.birthDateController.value.text =
              DateFormat('yyyy-MM-dd').format(picked);
        }
      },
    );
  }

  Widget _buildGenderSelection() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("Select Gender:".tr),
            Row(
              children: [
                Radio<String>(
                  value: "Male",
                  groupValue: selectedGender.value,
                  onChanged: (val) {
                    selectedGender.value = val!;
                    registrationController.gender.value = val;
                  },
                ),
                 Text("Male".tr),
                Radio<String>(
                  value: "Female",
                  groupValue: selectedGender.value,
                  onChanged: (val) {
                    selectedGender.value = val!;
                    registrationController.gender.value = val;
                  },
                ),
                 Text("Female".tr),
              ],
            )
          ],
        ));
  }
}

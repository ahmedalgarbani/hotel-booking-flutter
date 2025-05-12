import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/GuestController.dart';
import 'package:hotels/GTX/controller/Register_Controll.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/controller/send_controller.dart';
import 'package:hotels/GTX/views/widgets/registers/mainregisre.dart';
import 'package:intl/intl.dart';

class AddGuestScreen extends StatefulWidget {
  final int booking_id;
  AddGuestScreen({required this.booking_id, super.key});

  @override
  State<AddGuestScreen> createState() => _AddGuestScreenState();
}

class _AddGuestScreenState extends State<AddGuestScreen> {
  final registrationController = Get.find<GuestController>();

  final RxString selectedGender = 'male'.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      registrationController.booking_id.value = widget.booking_id;
      print(
          "registrationController.booking_id.value${registrationController.booking_id.value}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text("Add Guest".tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: GetX<RegistrationController>(
          builder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: _buildTextField(
                          context,
                          "First Name".tr,
                          Icons.person,
                          keyboardType: TextInputType.text,
                          registrationController.usernameController.value),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: _buildTextField(
                        context,
                        "Phone".tr,
                        Icons.phone,
                        keyboardType: TextInputType.phone,
                        registrationController.phoneController.value,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.all(5),
                          child: _buildBirthDatePicker(context))),
                  Expanded(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1),
                        image: registrationController.personalCard.value != null
                            ? DecorationImage(
                                image: FileImage(
                                    registrationController.personalCard.value!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: registrationController.personalCard.value == null
                          ? IconButton(
                              onPressed: () {
                                registrationController.personalCardDialog();
                              },
                              icon: Icon(Icons.account_box,size: 60,))
                          : null,
                    ),
                  ),
                ],
              ),
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
                onPressed: () async {
                  registrationController.prontbookingid();
                  await registrationController.addGuessBooking();
                },
                child: Text("Add Guest".tr),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String hint, IconData icon,
      TextEditingController controller,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
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
                  value: "male",
                  groupValue: selectedGender.value,
                  onChanged: (val) {
                    selectedGender.value = val!;
                    registrationController.gender.value = val;
                  },
                ),
                Text("Male".tr),
                Radio<String>(
                  value: "female",
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

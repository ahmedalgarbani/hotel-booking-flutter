import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/Register_Controll.dart';
import 'package:hotels/GTX/controller/otp_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CheckCodeScreen extends StatefulWidget {
  CheckCodeScreen({super.key});

  @override
  State<CheckCodeScreen> createState() => _CheckCodeScreenState();
}

class _CheckCodeScreenState extends State<CheckCodeScreen> {
  final OTPController controller = Get.find<OTPController>();
  final OTPController controllerotp = Get.find<OTPController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final registrationController = Get.find<RegistrationController>();

  final TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text("Verify Code".tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: GetBuilder<OTPController>(
            builder: (_) => Column(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset("assets/imagehome.png"),
                        height: 200,
                        width: 100,
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      Text(
                        "Enter the 6-digit code sent to your phone".tr,
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        child: PinCodeTextField(
                          appContext: context,
                          length: 6,
                          controller: controller.codeController,
                          autoFocus: true,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            activeColor: Colors.green,
                            selectedColor: Colors.blue,
                            inactiveColor: Colors.grey,
                            activeFillColor: Colors.green.shade100,
                            selectedFillColor: Colors.blue.shade100,
                            inactiveFillColor: Colors.grey.shade200,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 50,
                            fieldWidth: 45,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          onCompleted: (v) {},
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await controller.verifyCode();
                        },
                        child: Text("Verify".tr),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/controller/Register_Controll.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/controller/login_controller.dart';
import 'package:hotels/GTX/services/addUser.dart';
import 'package:hotels/GTX/services/login.dart';
import 'package:hotels/GTX/views/screens/favoriteScerrns/favoritescreen.dart';
import 'package:hotels/GTX/views/screens/mainpagescreens/homepage.dart';
import 'package:hotels/GTX/views/widgets/favoritewidget/favorite.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _BookingState();
}

class _BookingState extends State<LoginScreen> {
  bool isLoading = false;
  final RegistrationController registrationController =
      Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 15, bottom: 20),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Go Ahead And Set Up \n Your  Account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                      Text(
                        "Create Or SignIn Your Acccount ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
                      ),
                    ],
                  )),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  indicator: const BoxDecoration(
                    color: Color.fromARGB(
                      220,
                      7,
                      86,
                      152,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: double.infinity,
                        child: Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: double.infinity,
                        child: Text(
                          "Register",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 500,
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildLoginTab(),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildRegisterTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildLoginTab() {
  return SingleChildScrollView(
    child: GetX<SignupController>(
      builder: (ControllerSginup) => Column(
        children: [
          const SizedBox(height: 20),
          _buildTextField(
              hint: "E-mail ID",
              icon: Icons.email,
              mainTextContrller: ControllerSginup.emailController.value),
          const SizedBox(height: 10),
          _buildTextField(
              hint: "Password",
              icon: Icons.lock,
              obscureText: true,
              mainTextContrller: ControllerSginup.passwordController.value),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {},
                      activeColor: Colors.blue,
                    ),
                    const Text(
                      "Remember me",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _ButtonComplet(
              namebutton: "Login",
              isLoading: false,
              rigester: ControllerSginup.signup),
          const SizedBox(height: 20),
          // const Text(
          //   "Or login with",
          //   style: TextStyle(color: Colors.grey),
          // ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // _buildSocialButton(icon: Icons.g_mobiledata, label: "Google"),
              // const SizedBox(width: 10),
              // _buildSocialButton(icon: Icons.apple, label: "Apple"),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildRegisterTab() {
  final ConfirmController confirmController = Get.find<ConfirmController>();
  return SingleChildScrollView(
    child: GetX<RegistrationController>(
      builder: (registrationController) => Column(
        children: [
          const SizedBox(height: 20),
          _buildTextField(
              hint: "User-Name ",
              icon: Icons.info,
              mainTextContrller:
                  registrationController.usernameController.value),
          const SizedBox(height: 20),
          _buildTextField(
              hint: "First-Name ",
              icon: Icons.info,
              mainTextContrller:
                  registrationController.firstNameController.value),
          const SizedBox(height: 20),
          _buildTextField(
              hint: "Last-Name ",
              icon: Icons.info,
              mainTextContrller:
                  registrationController.lastNameController.value),
          const SizedBox(height: 20),
          _buildTextField(
              hint: "E-mail ID",
              icon: Icons.email,
              mainTextContrller: registrationController.emailController.value),
          const SizedBox(height: 10),
          _buildTextField(
              hint: "Password",
              icon: Icons.lock,
              obscureText: true,
              mainTextContrller:
                  registrationController.passwordController.value),
          const SizedBox(height: 10),
          _buildTextField(
              hint: "Phone-Number",
              icon: Icons.phone,
              mainTextContrller: registrationController.phoneController.value),
          const SizedBox(height: 10),
          // _buildTextField(
          //     hint: "Confirm Password", icon: Icons.lock, obscureText: true, mainTextContrller: null),
          const SizedBox(height: 20),
            TextButton(
                onPressed: () async {
                  await confirmController.fetchImageDialog();
                },
                child: Text("choose image")),
          _ButtonComplet(
              namebutton: "Register",
              isLoading: false,
              rigester: registrationController.register),
        
        ],
      ),
    ),
  );
}

Widget _buildTextField({
  required String hint,
  required IconData icon,
  bool obscureText = false,
  required TextEditingController mainTextContrller,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        border: Border.all(color: Colors.grey)),
    child: TextField(
      controller: mainTextContrller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    ),
  );
}

// Widget _buildSocialButton({required IconData icon, required String label}) {
//   return ElevatedButton.icon(
//     onPressed: () {},
//     icon: Icon(icon, color: Colors.white),
//     label: Text(label),
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Color.fromRGBO(21, 37, 65, 1),
//       foregroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(25),
//       ),
//       minimumSize: const Size(150, 50),
//     ),
//   );
// }
Widget _ButtonComplet(
    {required String namebutton,
    required bool isLoading,
    required VoidCallback rigester}) {
  return GetX<SignupController>(
    builder: (ControllerSginup) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ControllerSginup.isLoading.value
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                rigester();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                  220,
                  7,
                  86,
                  152,
                ),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                namebutton,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
    ),
  );
}

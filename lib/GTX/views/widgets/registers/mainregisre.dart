import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/login_controller.dart';
import 'package:hotels/GTX/views/widgets/registers/Registerwidget.dart';

class LoginScreen extends StatelessWidget {
  final SignupController signupController = Get.find();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text("Sign In".tr)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: GetX<SignupController>(
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  _buildHeader(context),
                  const SizedBox(height: 40),
                  _buildLoginForm(controller, context),
                  const SizedBox(height: 32),
                  _buildLoginButton(controller),
                  const SizedBox(height: 24),
                  _buildDivider(),
                  const SizedBox(height: 32),
                  _buildRegisterLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 70,
          width: 70,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(18),
          ),
          child:Image.asset("assets/icon-192.png")
        ),
        const SizedBox(height: 24),
        Text(
          "Welcome Back".tr,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          "Sign in to continue".tr,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(SignupController controller, BuildContext context) {
    return Column(
      children: [
        _buildTextField(
          keyboardType: TextInputType.emailAddress,
          context: context,
          hint: "Email".tr,
          icon: Icons.email_outlined,
          mainTextContrller: controller.emailController.value,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          keyboardType: TextInputType.visiblePassword,
          context: context,
          hint: "Password".tr,
          icon: Icons.lock_outline,
          obscureText: true,
          mainTextContrller: controller.passwordController.value,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool obscureText = false,
    required TextEditingController mainTextContrller,
    required BuildContext context,
    TextInputType keyboardType = TextInputType.text, 
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: mainTextContrller,
        obscureText: obscureText,
        keyboardType: keyboardType, 
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildLoginButton(SignupController controller) {
    return Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: controller.isLoading.value ? null : controller.signup,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: controller.isLoading.value
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                "Sign In".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.withOpacity(0.3))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("Or continue with".tr),
        ),
        Expanded(child: Divider(color: Colors.grey.withOpacity(0.3))),
      ],
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ".tr,
          style: TextStyle(
            color: Theme.of(Get.context!)
                .colorScheme
                .onBackground
                .withOpacity(0.7),
          ),
        ),
        TextButton(
          onPressed: () => Get.to(() => Registerwidget()),
          child: Text(
            "Sign Up".tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

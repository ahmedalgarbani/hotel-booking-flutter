import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hotels/GTX/views/widgets/registers/Registerwidget.dart';
import 'package:hotels/GTX/views/widgets/registers/mainregisre.dart';

class AuthSelectionScreen extends StatelessWidget {
  const AuthSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo/Icon
              Container(
                height:110 ,
                width: 110,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child:Image.asset("assets/icon-192.png")
              ),
              const SizedBox(height: 40),
              
              // Welcome Text
              Text(
                "Welcome to Hotels".tr,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Choose how you want to continue".tr,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 60),
              
              // Login Button
              _buildButton(
                context: context,
                title: "Sign In".tr,
                subtitle: "Already have an account?".tr,
                icon: Icons.login,
                onPressed: () => Get.to(() => LoginScreen()),
              ),
              const SizedBox(height: 20),
              
              // Register Button
              _buildButton(
                context: context,
                title: "Create Account".tr,
                subtitle: "New to Hotels?".tr,
                icon: Icons.person_add,
                isPrimary: false,
                onPressed: () => Get.to(() => Registerwidget()),
              ),
             
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onPressed,
    bool isPrimary = true,
  }) {
    return Container(
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary 
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
          foregroundColor: isPrimary 
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.primary,
          elevation: isPrimary ? 2 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isPrimary 
              ? BorderSide.none
              : BorderSide(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: isPrimary 
                      ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.8)
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
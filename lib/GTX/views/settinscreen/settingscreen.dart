import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/services/logout.dart';
import 'package:hotels/GTX/views/screens/NotificationScreen/NotificationScreen.dart';
import 'package:hotels/GTX/views/screens/ProfileScreen/ProfileScreen.dart';
import 'package:hotels/GTX/views/widgets/homepage/languagebottunsheet.dart';
import 'package:hotels/GTX/views/widgets/settingwiget/settingscreen.dart';

class Settingscreen extends StatefulWidget {
  const Settingscreen({super.key});

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          appBarsectionn(),
          ProfileInfo(),
          buttonEditProfile(
              onPressed: () {
                Get.to(() => ProfileScreen());
              },
              nameButton: "Edit Profile".tr),
          SettingItem(
            context: context,
            icon: Icons.location_on,
            text: "Notifications",
            onTap: () {
              Get.to(() => NotificationScreen());
            },
          ),
          SettingItem(
            context: context,
            icon: Icons.person,
            text: "My personal File",
            onTap: () {
              Get.to(() => ProfileScreen());
            },
          ),
          SettingItem(
            context: context,
            icon: Icons.person,
            text: "Language",
            onTap: () {
              languagebuttnsheet(context: context);
            },
          ),
          customDivider(),
          SettingItem(
            context: context,
            icon: Icons.person,
            text: "Logout",
            onTap: () {
              AuthService().logOut(context);
              ;
            },
          ),
        ],
      ),
    );
  }
}

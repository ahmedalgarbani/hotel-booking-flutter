import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/ThemeController.dart';
import 'package:hotels/GTX/controller/showProfileinfo.dart';

PreferredSizeWidget appBarsection() {
  return AppBar(
    title: Text("Setting Profile"),
    centerTitle: true,
  );
}

Widget appBarsectionn() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),

        const Expanded(
          child: Center(
            child: Text(
              "Setting Profile",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        IconButton(
          icon: Icon(
            Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          ),
          onPressed: () {
            Get.find<ThemeController>().toggleTheme();
          },
        ),
      ],
    ),
  );
}

Widget ProfileInfo() {
  final Showprofileinfo showprofileinfo = Get.find<Showprofileinfo>();

  return Obx(() {
    final hasUser = showprofileinfo.profileuserlist.isNotEmpty;
    final user = hasUser ? showprofileinfo.profileuserlist.first : null;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Theme.of(Get.context!).colorScheme.secondary,
            child: ClipOval(
              child: hasUser && user!.image != null
                  ? Image.network(
                      user.image!,
                      fit: BoxFit.cover,
                      width: 70,
                      height: 70,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.cover),
                    )
                  : Image.asset('assets/images/profile.png',
                      fit: BoxFit.cover, width: 70, height: 70),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hasUser
                    ? '${user!.firstName} ${user.lastName}'
                    : 'اسم المستخدم'.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                hasUser ? user!.email : 'email@example.com'.tr,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  });
}

Widget buttonEditProfile({required void Function() onPressed,required String nameButton}) {
  return Container(
    margin: EdgeInsets.all(10),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        nameButton.tr,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget SettingItem({
  required BuildContext context,
  required IconData icon,
  required String text,
  required void Function() onTap,
}) {
  // final isDark = Theme.of(context).brightness == Brightness.dark;
  // final iconColor = isDark ? Colors.white : Color.fromARGB(255, 39, 63, 70);
  final isDarkcontainer = Theme.of(context).brightness == Brightness.dark;
  final iconColorcontainer =
      isDarkcontainer ? Colors.grey.shade700 : Color.fromARGB(255, 39, 63, 70);
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: iconColorcontainer,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: iconColorcontainer),
          ],
        ),
      ),
    ),
  );
}

Widget customDivider() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Divider(color: Colors.grey),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/NotificationsController.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationsController controller = Get.find<NotificationsController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title:  Text('Notifications'.tr),
        centerTitle: true,
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.notificationsList.isEmpty) {
            return  Center(child: Text("No notifications available".tr));
          }

          return ListView.builder(
            itemCount: controller.notificationsList.length,
            itemBuilder: (context, index) {
              final notification = controller.notificationsList[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 3,
                color: notification.isRead ? Colors.grey[300] : Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: notification.isRead ? Colors.grey : Colors.blue,
                    child: const Icon(Icons.notifications, color: Colors.white),
                  ),
                  title: Text(
                    notification.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(notification.message),
                  trailing: Text(notification.sendTime),
                  onTap: () {
                    if (notification.actionUrl.isNotEmpty) {

                      print('Open URL: ${notification.actionUrl}');
                    }
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

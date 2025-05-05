import 'package:get/get.dart';
import 'package:hotels/GTX/Models/NotificationMode.dart';
import 'package:hotels/GTX/services/Notificationsservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class NotificationsController extends GetxController {
  var notificationsList = <NotificationsModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    try {
      notificationsList.value = await GetAllNotifications().fetchNotifications();
    } catch (e) {
      print('❌ Error fetching notifications: $e');
    } finally {
      isLoading.value = false;
    }
  }  
}

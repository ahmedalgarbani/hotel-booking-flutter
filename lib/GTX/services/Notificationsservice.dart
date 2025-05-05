import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/Models/NotificationMode.dart';
import 'package:hotels/GTX/helper/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetAllNotifications {
  
  Future<List<NotificationsModel>> fetchNotifications() async {
  
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    final String url = 'http://192.168.60.85:8000/api/notifications/';

    List<NotificationsModel> data =
        await Api().getAllNotifications(url: url, token: token);
    return data;
  }
}

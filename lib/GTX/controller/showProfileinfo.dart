import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/rigetermodel.dart';
import 'package:hotels/GTX/services/showprifileData.dart';

class Showprofileinfo extends GetxController {
  var profileuserlist = <Rigetermodel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserFromPrefs(); 
    fetchAllUser(); 
  }

  void fetchAllUser() async {
    try {
      isLoading.value = true;
      List<Rigetermodel> data = await Showprifiledata().getAlluser();
      profileuserlist.assignAll(data);
      saveUserToPrefs(data); // خزّن البيانات الجديدة
      print("✅ Fetched users: ${profileuserlist.length}");
    } catch (e) {
      print(" Error fetching profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveUserToPrefs(List<Rigetermodel> users) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(users.map((e) => e.toJson()).toList());
    await prefs.setString('cached_user_data', encoded);
  }

  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('cached_user_data');

    if (cached != null) {
      try {
        final List<dynamic> decoded = jsonDecode(cached);
        final cachedUsers = decoded.map((e) => Rigetermodel.fromJson(e)).toList();
        profileuserlist.assignAll(cachedUsers.cast<Rigetermodel>());
        print(" Loaded cached profile data");
      } catch (e) {
        print(" Error decoding cached user: $e");
      }
    }
  }
}

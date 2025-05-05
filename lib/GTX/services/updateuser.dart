import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/Models/rigetermodel.dart';
import 'package:hotels/GTX/controller/showProfileinfo.dart';
import 'package:hotels/GTX/helper/api.dart';
import 'package:hotels/GTX/helper/updateapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Updateuser {
  Future<Rigetermodel> updateProfile({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
    required String selectedGender,
    required String birth_date,
    required File? image,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    Map<String, dynamic> data = await Updateapi().put(
      url: 'http://192.168.60.85:8000/api/user-profile/',
      body: {
        'username': username,
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'gender': selectedGender,
        'birth_date': birth_date,
      },
      image: image,
      token: token,
    );
    Get.find<Showprofileinfo>().fetchAllUser();

    return Rigetermodel.fromJson(data);
  }
}

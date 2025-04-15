import 'dart:io';

import 'package:hotels/GTX/Models/rigetermodel.dart';
import 'package:hotels/GTX/helper/api.dart';

class AddUser {
  Future<Rigetermodel> addUser({
  required String username,
  required String email,
  required String password,
  required String firstName,
  required String lastName,
  required String phone,
  required File? image,
}) async {
  Map<String, dynamic> data = await Api().post(
    url: 'http://192.168.183.85:8000/api/register/',
    body: {
      'username': username,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
    },
    image: image,
   
  );

  return Rigetermodel.fromJson(data);
}

}

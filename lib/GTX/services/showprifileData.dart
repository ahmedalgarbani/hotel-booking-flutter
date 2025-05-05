import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hotels/GTX/Models/rigetermodel.dart';
import 'package:hotels/GTX/helper/updateapi.dart';

class Showprifiledata {
  Future<List<Rigetermodel>> getAlluser() async {
   
    final String url = 'http://192.168.60.85:8000/api/user-profile/';

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      throw Exception("User not authenticated");
    }

    List<Rigetermodel> data =  await Updateapi().getupdateprofile(
      url: url,
      token: token,
    );

    return data;
  }
}

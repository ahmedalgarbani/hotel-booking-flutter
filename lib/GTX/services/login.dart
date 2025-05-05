import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/Models/login_Model.dart';
import 'package:hotels/GTX/controller/Booking_details_Controller.dart';
import 'package:hotels/GTX/controller/Controller_favourites.dart';
import 'package:hotels/GTX/controller/categoriesController.dart';
import 'package:hotels/GTX/controller/hotelLocation_Controller.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/controller/showProfileinfo.dart';
import 'package:hotels/GTX/helper/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
 Future<Login?> loginUser({required String email, required String password}) async {

  
  Map<String, dynamic>? data = await Api().post(
    url: 'http://192.168.60.85:8000/api/login/',
    body: {'email': email, 'password': password},
  );

  if (data != null && data.containsKey('tokens')) {
    String accessToken = data['tokens']['access'];
    String refreshToken = data['tokens']['refresh'];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);

    print("Access Token: $accessToken");

     Get.find<FavouritesController>().fetchFavourites();
     Get.find<BookingController>().fetchBookings();
     Get.find<Showprofileinfo>().fetchAllUser();
     
     

    return Login.fromJson(data['user']);
  }
  return null;
}

}

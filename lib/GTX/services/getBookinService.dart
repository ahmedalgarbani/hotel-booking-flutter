import 'package:hotels/GTX/Models/BookingModel.dart';
import 'package:hotels/GTX/helper/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class getBookingService {
  Future<List<BookingModel>> getBookings() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) throw Exception("User not authenticated");

    List<BookingModel> data = await Api().getBookings(
      url: "http://192.168.183.85:8000/api/bookings/",
      token: token,
    );

    return data;
  }
}
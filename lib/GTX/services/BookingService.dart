import 'dart:convert';

import 'package:hotels/GTX/Models/BookingModel.dart';
import 'package:hotels/GTX/helper/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingService {
  Future<Map<String, dynamic>?> createBooking({
    required int hotelId,
    required int roomId,
    required String checkInDate,
    required String checkOutDate,
    required double amount,
    required int roomsBooked,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    Map<String, dynamic>? data = await Api().postBooking(
      url: 'http://192.168.183.85:8000/api/bookings/create_booking/',
      body: {
        'hotel_id': hotelId,
        'room_id': roomId,
        'check_in_date': checkInDate,
        'check_out_date': checkOutDate,
        'amount': amount,
        'rooms_booked': roomsBooked,
      },
      token: token,
    );
             

  

    if (data != null) {
    var bookingId = data['id'];
    print("Booking ID: $bookingId");
  }
print("token Booking  ");
    return data;
  }
}





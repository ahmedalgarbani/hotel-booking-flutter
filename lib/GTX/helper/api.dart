import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/Models/BookingModel.dart';
import 'package:hotels/GTX/Models/NotificationMode.dart';
import 'package:hotels/GTX/Models/PaymentModel.dart';
import 'package:hotels/GTX/Models/PaymentOption_model.dart';
import 'package:hotels/GTX/Models/categories_Model.dart';
import 'package:hotels/GTX/Models/favroute_model.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<List<HotelsModel>> get({required String url, String? token}) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    print("urlurlurlurlurlurlurlurlurlurl");
    print("urlurlurlurlurlurlurlurlurlurl");
    print("urlurlurlurlurlurlurlurlurlurl");
    print("url ================= $url");
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    print("🔵 API Response: ${response.body}");

    var decodedData = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      var data = jsonDecode(decodedData);

      if (data.containsKey('results') && data['results'] is List) {
        var hotels = data['results'];

        print("Fetched hotels ======================= $hotels");

        return hotels
            .map<HotelsModel>((hotel) => HotelsModel.fromJson(hotel))
            .toList();
      } else {
        print(". No results found in response !");
        return [];
      }
    } else {
      throw Exception("Error in loading: ${response.statusCode}");
    }
  }

  Future<List<dynamic>> getList({required String url, String? token}) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(Uri.parse(url), headers: headers);

    print("🔵 API Response: ${response.body}");

    var decodedData = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      var data = jsonDecode(decodedData);
      if (data.containsKey('results') && data['results'] is List) {
        return data['results'];
      } else {
        print(". No results found in response!");
        return [];
      }
    } else {
      throw Exception("Error in loading: ${response.statusCode}");
    }
  }

  Future<List<CategoriesModel>> getAllCategoreies(
      {required String url, String? token}) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    http.Response response = await http.get(Uri.parse(url), headers: headers);

    print("🔵 API Response Categories: ${response.body}");

    var decodedData = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      var data = jsonDecode(decodedData);

      if (data.containsKey('results') && data['results'] is List) {
        var hotels = data['results'];

        print("Fetched Categories ======================= $hotels");

        return hotels
            .map<CategoriesModel>((hotel) => CategoriesModel.fromJson(hotel))
            .toList();
      } else {
        print(". No results found in response for Categories !");
        return [];
      }
    } else {
      throw Exception("Error in loading: ${response.statusCode}");
    }
  }
  Future<List<NotificationsModel>> getAllNotifications({
    required String url,
    String? token,
  }) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(Uri.parse(url), headers: headers);
    print("🔔 API Response Notifications: ${response.body}");

    final decodedData = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(decodedData);

      if (jsonData.containsKey('results') && jsonData['results'] is List) {
        final List<dynamic> notifications = jsonData['results'];
        return notifications
            .map((json) => NotificationsModel.fromJson(json))
            .toList();
      } else {
        print("🚫 No results found in notifications response.");
        return [];
      }
    } else {
      throw Exception('❌ Error loading notifications: ${response.statusCode}');
    }
  }



  Future<void> markNotificationAsRead(int id, String token) async {
  final url = 'http://192.168.183.85:8000/api/notifications/$id/mark_as_read/';

  final headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final response = await http.post(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    print("✅ Notification marked as read.");
  } else {
    print("❌ Failed to mark as read: ${response.statusCode}");
  }
}

  Future<List<BookingModel>> getBookings(
      {required String url, String? token}) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    print(" Bookinggggggggggggggg API Response: ${response.body}");

    var decodedData = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      var data = jsonDecode(decodedData);

      if (data.containsKey('results') && data['results'] is List) {
        List<dynamic> bookings = data['results'];
        return bookings.map((json) => BookingModel.fromJson(json)).toList();
      } else {
        print(" No results found in bookingsssssssssss response!");
        return [];
      }
    } else {
      throw Exception("Error in loading bookings: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>?> postBooking({
    required String url,
    String? token,
    Map<String, dynamic>? body,
  }) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body ?? {}),
    );

    print("🔵 API Response booking: ${response.body}");

    var decodedData = utf8.decode(response.bodyBytes);
    var data = jsonDecode(decodedData);

    print("🔵 API decodedData booking: $data");

    if (data is Map<String, dynamic> &&
        data.containsKey('error') &&
        data['error'] == "عدد الغرف المطلوب غير متوفر لكل الأيام المطلوبة") {
      Get.snackbar(
          "Booking Error", "عدد الغرف المطلوب غير متوفر لكل الأيام المطلوبة");
      return null;
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    } else {
      // Get.snackbar("","please check your ipadress"
      //     );
      throw Exception("خطأ في الحجز: ${response.statusCode}");
    }
  }

  Future<List<PaymentAccount>> getPayment(
      {required String url, String? token, Map<String, dynamic>? body}) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body ?? {}),
    );

    print("🔵 API Response payment: ${response.body}");

    var decodedData = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      var data = jsonDecode(decodedData);

      if (data is List) {
        print("Fetched payment ======================= $data");

        return data
            .map<PaymentAccount>((json) => PaymentAccount.fromJson(json))
            .toList();
      } else {
        print(". No results found in response!");
        return [];
      }
    } else {
      throw Exception("Error in loading: ${response.statusCode}");
    }
  }

  Future<List<favrourHotelsModel>> getfavrour(
      {required String url, String? token}) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    http.Response response = await http.get(Uri.parse(url), headers: headers);

    print("🔵 API Response: ${response.body}");

    var decodedData = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      var data = jsonDecode(decodedData);

      if (data.containsKey('results') && data['results'] is List) {
        List<dynamic> hotels = data['results'];

        List<favrourHotelsModel> hotelList = [];
        for (var hotelData in hotels) {
          if (hotelData.containsKey('hotel_data')) {
            var hotelJson = hotelData['hotel_data'];
            print("Hotel Data: ${hotelJson}");
            hotelList.add(favrourHotelsModel.fromJson(hotelJson));
          }
        }

        return hotelList;
      } else {
        print(". No results found in response!");
        return [];
      }
    } else {
      throw Exception("Error in loading: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> postMultipart({
    required String url,
    required Map<String, String> body,
    required File imageFile,
    required String token,
  }) async {
    try {
      print(" Sending request to $url");
      print(" Fields: $body");

      if (!imageFile.existsSync()) {
        throw Exception("الصورة غير موجودة");
      }

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields.addAll(body);
      request.fields.remove('user');
      request.files.add(
          await http.MultipartFile.fromPath('transfer_image', imageFile.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print(" Status Code: ${response.statusCode}");
      print(" Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = jsonDecode(response.body);
        if (jsonBody is Map<String, dynamic>) return jsonBody;
        throw Exception("Invalid JSON format");
      } else {
        throw Exception(" HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error in postMultipart: $e");
    }
  }

  Future<Map<String, dynamic>?> postPayment({
    required String url,
    String? token,
    required int bookingId,
    required int paymentMethodId,
    required double paymentSubtotal,
    required double paymentTotalAmount,
    required String paymentCurrency,
    required String paymentType,
    required File transferImage,
    String? paymentNote,
    double? paymentDiscount,
  }) async {
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.fields['booking'] = bookingId.toString();
    request.fields['payment_method'] = paymentMethodId.toString();
    request.fields['payment_subtotal'] = paymentSubtotal.toString();
    request.fields['payment_totalamount'] = paymentTotalAmount.toString();
    request.fields['payment_currency'] = paymentCurrency;
    request.fields['payment_type'] = paymentType;
    request.fields['payment_note'] = paymentNote ?? '';
    request.fields['payment_discount'] = (paymentDiscount ?? 0).toString();

    request.files.add(
      await http.MultipartFile.fromPath(
        'transfer_image',
        transferImage.path,
      ),
    );

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print("🔵 Response Status Code: ${response.statusCode}");
    print("🔵 Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Payment failed: ${response.statusCode}');
    }
  }

//    Future<dynamic> post({
//   required String url,
//   required Map<String, dynamic> body,
//   @required String? token,
// }) async {
//   Map<String, String> headers = {
//     'Accept': 'application/json',
//     'Content-Type': 'application/json',
//   };

//   if (token != null) {
//     headers['Authorization'] = 'Bearer $token';
//   }

//   http.Response response = await http.post(
//     Uri.parse(url),
//     body: jsonEncode(body),
//     headers: headers,
//   );

//   print("Response Status Code: ${response.statusCode}");
//   print("Response Body: ${response.body}");

//   if (response.statusCode == 200 || response.statusCode == 201) {
//     return jsonDecode(response.body);
//   } else {
//     throw Exception("هناك مشكلة في الطلب: ${response.statusCode}");
//   }
// }

  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> body,
    File? image,
    String? token,
  }) async {
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.fields
        .addAll(body.map((key, value) => MapEntry(key, value.toString())));

    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', image.path),
      );
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("هناك مشكلة في الطلب: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> postt({
    required String url,
    required dynamic body,
    @required String? token,
  }) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    http.Response response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    return jsonDecode(response.body);
  }

  Future<dynamic> delete({
    required String url,
    String? token,
    required Map<String, dynamic> body,
  }) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    http.Response response = await http.delete(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: headers,
    );

    if (response.body.isNotEmpty) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}

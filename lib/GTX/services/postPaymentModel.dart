import 'dart:io';
import 'package:hotels/GTX/Models/PaymentModel.dart';
import 'package:hotels/GTX/helper/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Postpaymentmodel {
  Future<PaymentModel> makePayment({
    required int bookingId,
    required int paymentMethodId,
    required double paymentSubtotal,
    required double paymentTotalAmount,
    required String paymentCurrency,
    required String paymentType,
    required File transferImage,
    required String? paymentNote,
    required String paymentDiscount,
    required int paymentStatus,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) throw Exception("User not authenticated");

    Map<String, String> bodys = {
      'booking_id': bookingId.toString(),
      'payment_method_id': paymentMethodId.toString(),
      "payment_subtotal": paymentSubtotal.toString(),
      "payment_totalamount": paymentTotalAmount.toString(),
      "payment_currency": paymentCurrency,
      "payment_type": paymentType,
      "payment_note": paymentNote ?? '',
      "payment_discount": paymentDiscount,
    };

    Map<String, dynamic> data = await Api().postMultipart(
      url: 'http://192.168.183.85:8000/api/payment/make_payment/',
      body: bodys,
      imageFile: transferImage,
      token: token,
    );

    print("data=======================");
    if (data.isEmpty) {
      throw Exception("the request from server is null :$data");
    }

    return PaymentModel.fromJson(data);
  }
}

// class PaymentService {
//  Future<Map<String, dynamic>?> createPayment({
//   required int bookingId,
//   required int paymentMethodId,
//   required double paymentSubtotal,
//   required double paymentTotalAmount,
//   required String paymentCurrency,
//   required String paymentType,
//   required File transferImage,
//   String? paymentNote,
//   double? paymentDiscount,
// }) async {
//   final prefs = await SharedPreferences.getInstance();
//   String? token = prefs.getString('access_token');

//    Map<String, dynamic>? data = await Api().postPayment(
//     url: 'http://192.168.183.85:8000/api/payment/make_payment/',
//     token: token,
//     bookingId: bookingId,
//     paymentMethodId: paymentMethodId,
//     paymentSubtotal: paymentSubtotal,
//     paymentTotalAmount: paymentTotalAmount,
//     paymentCurrency: paymentCurrency,
//     paymentType: paymentType,
//     transferImage: transferImage,
//     paymentNote: paymentNote,
//     paymentDiscount: paymentDiscount,
//   );
//   return data;
// }
// }

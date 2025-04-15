import 'package:hotels/GTX/Models/PaymentOption_model.dart';
import 'package:hotels/GTX/helper/api.dart';

class ShowPaymentOptionService {
Future<List<PaymentAccount>> getAllPayments({required int hotelId}) async {
  final String url = 'http://192.168.183.85:8000/api/hotel-payment-methods/active_payment_methods/';
  List<PaymentAccount> data = await Api().getPayment(url: url, body: {"hotel_id": hotelId});
  return data;
}

}



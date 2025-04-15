import 'package:get/get.dart';
import 'package:hotels/GTX/Models/PaymentOption_model.dart';
import 'package:hotels/GTX/services/BookingService.dart';
import 'package:hotels/GTX/services/show_payment_option_service.dart';

class PaymentOptionController extends GetxController {
  var paymentOptionList = <PaymentAccount>[].obs;
  // var Bookinglist = <dynamic>[].obs;
  // var paymentMethodId = ''.obs;
  var selectedIndex = (-1).obs;
  var nameAccount = ''.obs;
  var numberAccount = ''.obs;
  var description = ''.obs;
  var iban = ''.obs;
  var selectedCurrency = ''.obs;
  var isLoading = false.obs;

  void fetchPayment(int hotelId) async {
    try {
      isLoading.value = true;
      List<PaymentAccount> paymentList =
          await ShowPaymentOptionService().getAllPayments(hotelId: hotelId);
      paymentOptionList.assignAll(paymentList);
    } catch (e) {
      print(" worong when uploade  $e");
    } finally {
      isLoading.value = false;
    }
  }

  void updateSelectedPayment(int index, PaymentAccount payment) {
    selectedIndex.value = index;
    nameAccount.value = payment.accountName;
    numberAccount.value = payment.accountNumber;
    description.value = payment.description;
    iban.value = payment.iban;
    // paymentMethodId.value=payment.id.toString();
    selectedCurrency.value = '';
    // print(paymentMethodId.value);
  }
}

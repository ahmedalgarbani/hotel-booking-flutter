import 'package:get/get.dart';
import 'package:hotels/GTX/Models/BookingModel.dart';
import 'package:hotels/GTX/services/BookingService.dart';
import 'package:hotels/GTX/services/getBookinService.dart';


class BookingController extends GetxController {
  var bookings = <BookingModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  void fetchBookings() async {
    try {
      isLoading.value = true;
      List<BookingModel> data = await getBookingService().getBookings();
      bookings.assignAll(data);
    } catch (e) {
      print(" Error fetching bookings: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
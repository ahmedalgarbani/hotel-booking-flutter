import 'package:get/get.dart';
import 'package:hotels/GTX/Models/BookingModel.dart';
import 'package:hotels/GTX/services/BookingService.dart';
import 'package:hotels/GTX/services/getBookinService.dart';

class BookingController extends GetxController {
  var bookings = <BookingModel>[].obs;
  var bookedBookings = <BookingModel>[].obs;
  var historyBookings = <BookingModel>[].obs;
  var serviceRoom = <BookingDetail>[].obs;
  var image_hotel = ''.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  void loadBookingDetailsById(int bookingId) {
  final booking = bookings.firstWhereOrNull((h) => h.id == bookingId);

  if (booking != null) {
    print("عدد الخدمات في booking.details: ${booking.details.length}");
    for (var detail in booking.details) {
      print("Service: ${detail.serviceName}, quantity: ${detail.quantity}");
    }

    serviceRoom.value = booking.details;

    print("hotel_namehotel_namehotel_namehotel_namehotel_name");
    print("hotel_name");
    print("hotel_name");
    print("Details: ${serviceRoom.length}");

    if (serviceRoom.isNotEmpty) {
      print("serviceName: ${serviceRoom.first.serviceName}");
    } else {
      print("no services available");
    }

  } else {
    serviceRoom.clear();
    print("No booking found with this ID");
  }
}


  void fetchBookings() async {
    try {
      isLoading.value = true;
      List<BookingModel> data = await getBookingService().getBookings();

      bookings.assignAll(data);

      final now = DateTime.now();
      bookedBookings.assignAll(data.where((b) {
        DateTime checkout = DateTime.parse(b.checkOutDate);
        return checkout.isAfter(now);
      }));

      historyBookings.assignAll(data.where((b) {
        DateTime checkout = DateTime.parse(b.checkOutDate);
        return checkout.isBefore(now) || checkout.isAtSameMomentAs(now);
      }));
    } catch (e) {
      print("Error fetching bookings: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

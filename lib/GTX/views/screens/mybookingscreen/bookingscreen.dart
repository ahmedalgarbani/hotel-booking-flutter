import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/views/widgets/mybooingwidget/bookingwidet.dart';

import '../../../controller/Booking_details_Controller.dart';

class Bookingscreen extends StatelessWidget {
  const Bookingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.find<BookingController>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Booking", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: Icon(Icons.tune, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  indicator: const BoxDecoration(
                    color: Color.fromARGB(
                      220,
                      7,
                      86,
                      152,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: double.infinity,
                        child: Text(
                          "Booked",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: double.infinity,
                        child: Text(
                          "History",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return TabBarView(
                  
                  children: [
                    ListView.builder(
                      itemCount: controller.bookings.length,
                      itemBuilder: (context, index) {
                        final booking = controller.bookings[index];
                        return bookingHotel(
                  hotel_name: booking.hotelName,
                  room_name: booking.roomName,
                  check_in_date: booking.checkInDate,
                  check_out_date: booking.checkOutDate,
                  rooms_booked: booking.roomsBooked.toString(),
                  amount: booking.amount.toString(),
                  imagePath: '',
                );
                      },
                    ),
                    const Center(child: Text("History (future logic here)")),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/views/screens/mainpagescreens/homepage.dart';
import 'package:hotels/GTX/views/widgets/ConnectionCheckWidget/ConnectionCheckWidget.dart';
import 'package:hotels/GTX/views/widgets/mybooingwidget/bookingwidet.dart';
import '../../../controller/Booking_details_Controller.dart';

class Bookingscreen extends StatefulWidget {
  const Bookingscreen({super.key});

  @override
  State<Bookingscreen> createState() => _BookingscreenState();
}




class _BookingscreenState extends State<Bookingscreen> {
  final NetworkController connectivityController =
      Get.find<NetworkController>();
      

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }  
  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.find<BookingController>();

     
      return DefaultTabController(
        length: 2,
        child: WillPopScope(
            onWillPop: () async {
      Get.offAll(Homepage()); 
      return true; 
        },
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              title: Text("My Booking".tr),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16, top: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search...".tr,
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
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
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
                            "Booking".tr,
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
                            "History".tr,
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
                        // Booked Tab
                        ListView.builder(
                          itemCount: controller.bookedBookings.length,
                          itemBuilder: (context, index) {
                            final booking = controller.bookedBookings[index];
                            print(
                                " bookingamount bookingamount bookingamount    ${booking.amount} ");
                            final totalamount = booking.amount.toString();
                            final roombooked = booking.roomsBooked.toString();
                            return bookingHotel(
                              hotel_name: booking.hotelName,
                              room_name: booking.roomName,
                              check_in_date: booking.checkInDate,
                              check_out_date: booking.checkOutDate,
                              status: booking.status,
                              amount: booking.amount.toString(),
                              imagePath: booking.hotelImage,
                              context: context,
                              id: booking.id,
                              bookingData: booking,
                              indexBooking: index,
                            );
                          },
                        ),
                        // History Tab
                        ListView.builder(
                          itemCount: controller.historyBookings.length,
                          itemBuilder: (context, index) {
                            final booking = controller.historyBookings[index];
                            return bookingHotel(
                              hotel_name: booking.hotelName,
                              room_name: booking.roomName,
                              check_in_date: booking.checkInDate,
                              check_out_date: booking.checkOutDate,
                              status: booking.status,
                              amount: booking.amount.toString(),
                              imagePath: booking.hotelImage,
                              context: context,
                              id: booking.id,
                              bookingData: booking,
                              indexBooking: index,
                            );
                          },
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      );
  
  }
}

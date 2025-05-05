import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/Booking_details_Controller.dart';
import 'package:hotels/GTX/Models/BookingModel.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/views/widgets/ConnectionCheckWidget/ConnectionCheckWidget.dart';
import 'package:intl/intl.dart';

class Bookingdetailsscreen extends StatefulWidget {
  final int id;
  final int indexBooking;
  final BookingModel bookingData;

  const Bookingdetailsscreen({
    Key? key,
    required this.id,
    required this.bookingData,
    required this.indexBooking,
  }) : super(key: key);

  @override
  State<Bookingdetailsscreen> createState() => _BookingdetailsscreenState();
}

class _BookingdetailsscreenState extends State<Bookingdetailsscreen> {
  final BookingController detailBooking = Get.find<BookingController>();

  @override
  void initState() {
    super.initState();
    detailBooking.loadBookingDetailsById(widget.id);
  }
final NetworkController connectivityController =
      Get.find<NetworkController>();
  @override
  Widget build(BuildContext context) {

   
     
        return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title:  Text("Booking Invoice".tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildBookingInfo(widget.bookingData),
            const SizedBox(height: 20),
            _buildServicesTable(), // جدول الخدمات
            const SizedBox(height: 20),
            // _buildTotalAmount(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildTotalAmount(context),
    );
  
  
     
  
  }

  // ------------------- Main Booking Info -------------------

  Widget _buildBookingInfo(BookingModel bookingData) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0.1, 0.1),
            blurRadius: 0.5,
            color: Colors.grey.withOpacity(0.3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nameBookingHotel(
            hotelname: bookingData.hotelName,
            userName: bookingData.userName,
            nameRoom: bookingData.roomName,
          ),
          _customDivider(),
          _DateBookingHotel(
            chechindate: bookingData.checkInDate,
            chechoutdate: bookingData.checkOutDate,
          ),
          _customDivider(),
          _roomBookingHotel(
            amount: bookingData.amount.toString(),
            numberRoom: bookingData.roomsBooked.toString(),
          ),
        ],
      ),
    );
  }

  Widget _nameBookingHotel({
    required String userName,
    required String hotelname,
    required String nameRoom,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.hotel),
                  const SizedBox(width: 6),
                  Text(
                    hotelname,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(userName),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.bed),
                  const SizedBox(width: 6),
                  Text(
                    nameRoom,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                statusText(widget.bookingData.status),
                style:
                    TextStyle(color: getStatusColor(widget.bookingData.status)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _DateBookingHotel({
  required String chechindate,
  required String chechoutdate,
}) {
  String formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoColumn("Check_In_Date".tr, formatDate(chechindate)),
        customVerticalDivider(),
        _buildInfoColumn("Check_Out_Date".tr, formatDate(chechoutdate)),
      ],
    ),
  );
}


  Widget _roomBookingHotel({
    required String numberRoom,
    required String amount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildInfoColumn("Price".tr, amount),
          customVerticalDivider(),
          _buildInfoColumn("Number Room".tr, numberRoom),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value),
      ],
    );
  }

  // ------------------- Services Table -------------------

  Widget _buildServicesTable() {
    return Obx(() {
      final services = detailBooking.serviceRoom;

      if (services.isEmpty) {
        return  Text("there is no service here".tr);
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          color: Theme.of(context).colorScheme.secondary,
          width: 400,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all( Colors.grey[700],),
            columns:  [
              DataColumn(
                  label: Text('Service'.tr,
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Price'.tr,
                      style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Total'.tr,
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: services.map((service) {
              return DataRow(cells: [
                DataCell(Text(service.serviceName)),
                DataCell(Text('${service.price}')),
                DataCell(Text('${service.total}')),
              ]);
            }).toList(),
          ),
        ),
      );
    });
  }

  // ------------------- Total Amount -------------------

  Widget _buildTotalAmount(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(16),
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      elevation: 5,
    ),
    onPressed: () {
      
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
          "Total Amount".tr,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
),
        ),
        Text(
          "${widget.bookingData.amount}",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            
          ),
        ),
      ],
    ),
  );
}


  // ------------------- Custom Dividers -------------------

  Widget _customDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(color: Colors.grey),
    );
  }

  Widget customVerticalDivider({
    double thickness = 1.0,
    Color color = Colors.grey,
    double height = 40.0,
    double marginHorizontal = 8.0,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
      width: thickness,
      height: height,
      color: color,
    );
  }

  // ------------------- Status Helpers -------------------

  String statusText(String status) {
  switch (status) {
    case "0":
      return "Pending".tr;
    case "1":
      return "Confirmed".tr;
    case "2":
      return "Cancelled".tr;
    default:
      return "Unknown".tr;
  }
}

  Color getStatusColor(String status) {
    switch (status) {
      case "0":
        return Colors.orange;
      case "1":
        return Colors.green;
      case "2":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

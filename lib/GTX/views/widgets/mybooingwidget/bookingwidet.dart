import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/BookingModel.dart';
import 'package:hotels/GTX/views/screens/BookingDetailsScreen/BookingDetailsScreen.dart';
import 'package:intl/intl.dart';

String formatDate(String isoDate) {
  DateTime date = DateTime.parse(isoDate);
  return DateFormat('yyyy-MM-dd').format(date);
}

Widget bookingHotel({
  required String hotel_name,
  required String room_name,
  required String check_in_date,
  required String check_out_date,
  required String status,
  required String amount,
  required String imagePath,
  required int id,
  required int indexBooking,
  required BookingModel bookingData,
  required BuildContext context,
}) {
  String formattedDates =
      "${formatDate(check_in_date)} to ${formatDate(check_out_date)}";

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 0,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          child: Image.network(
            imagePath,
            height: 180,
            width: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 180,
              child: const Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        hotel_name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            amount.toString(),
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '/night'.tr,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        room_name,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1),
                _buildInfoRow(
                    icon: Icons.person_outline,
                    label: "status Booking:".tr,
                    value: "$status",
                    id: id,
                    bookingData: bookingData,
                    indexBooking: indexBooking,
                    context: context),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(
    {required IconData icon,
    required String label,
    required String value,
    required int id,
    required int indexBooking,
    required BookingModel bookingData,
    required BuildContext context}) {
  return Row(
    children: [
      Icon(icon, size: 16, color: Colors.grey),
      const SizedBox(width: 4),
      Text(
        label,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
      const SizedBox(width: 4),
      Expanded(
        child: Text(
          statusText(value),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: getStatusColor(value),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      ElevatedButton(
          onPressed: () {
            Get.to(Bookingdetailsscreen(
              id: id,
              bookingData: bookingData,
              indexBooking: indexBooking,
            ));
          },
          child: Text(
            "Show Details".tr,
          ))
    ],
  );
}

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

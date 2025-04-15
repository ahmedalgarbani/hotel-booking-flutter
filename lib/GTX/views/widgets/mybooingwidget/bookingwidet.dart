import 'package:flutter/material.dart';
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
  required String rooms_booked,
  required String amount,
  required String imagePath,
}) {
  String formattedDates = "${formatDate(check_in_date)} to ${formatDate(check_out_date)}";

 String formattedCheckInDate = formatDate(check_in_date);
  String formattedCheckOutDate = formatDate(check_out_date);
  return Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          offset: Offset(1, 1),
          blurRadius: 1,
          spreadRadius: 1,
          blurStyle: BlurStyle.solid,
          color: Colors.grey.withOpacity(0.4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              height: 130,
               errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.broken_image),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    hotel_name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 17,
                  ),
                  Text(
                    room_name,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    r'$'"${amount}",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text('/night'),
                ],
              ),
              SizedBox(height: 2),
              Container(
                margin: EdgeInsets.only(right: 5),
                child: Divider(
                  color: Colors.grey.withOpacity(0.4),
                  thickness: 1,
                  height: 1,
                ),
              ),
              SizedBox(height: 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5),
                      Text("Date:"),
                      SizedBox(width: 5),
                      Text("${formattedDates}"),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5),
                      Text("Guest:"),
                      SizedBox(width: 5),
                      Text("2 Guests (${rooms_booked} room)"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:http/retry.dart';

Widget buildTabButton(String title, bool isActive, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Color.fromRGBO(21, 37, 65, 1) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color.fromRGBO(21, 37, 65, 1),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.blue,
        ),
      ),
    ),
  );
}

Widget roomImageHotel({
  required String mainImage,
  required String nameHotel,
  required String locationHotel,
}) {
  return Stack(
    children: [
      Image.network(
        mainImage,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
      ),
      Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
      Positioned(
        bottom: 16,
        left: 16,
        right: 16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameHotel,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 16),
                      SizedBox(width: 4),
                      Text('Rating', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(locationHotel,
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget roomTypeTitle({required String ServicTitle}) {
  return Container(
    margin: EdgeInsets.only(left: 5, top: 10, bottom: 5, right: 12),
    child: Column(
      children: [
        Text(
          ServicTitle,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

Widget nameRoomType({
  required String name,
}) {
  return Container(
    margin: EdgeInsets.only(left: 4, top: 10, right: 8),
    alignment: Alignment.bottomLeft,
    child: Row(
      children: [
        Text(
          "RoomName:".tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(name,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))
      ],
    ),
  );
}

Widget detailroom({
  required modelRoomm room,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Icon(Icons.bed, color: Color.fromARGB(239, 7, 86, 152)),
                SizedBox(width: 5),
                Text("${room.bedsCount} "),
                Text("beds : ".tr),
              ],
            ),
            SizedBox(width: 12),
            Row(
              children: [
                Icon(Icons.people, color: Color.fromARGB(239, 7, 86, 152)),
                SizedBox(width: 5),
                Text("${room.defaultCapacity} - ${room.maxCapacity} "),
                Text("Capacity : ".tr)
              ],
            ),
            SizedBox(width: 15),
            Row(
              children: [
                Icon(Icons.meeting_room,
                    color: Color.fromARGB(239, 7, 86, 152)),
                SizedBox(width: 5),
                Text("${room.roomsCount} "),
                Text("Rooms ".tr)
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// =====================================the discripton of roooms================================================
Widget titleDiscriptionroom({
  required String discription,
}) {
  bool isArabic = Get.locale?.languageCode == 'ar';

  return Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      alignment: isArabic ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Column(
        mainAxisAlignment:
            isArabic ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            alignment: isArabic ? Alignment.bottomRight : Alignment.bottomLeft,
            child: Text(
              'Description :'.tr,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: isArabic ? TextAlign.center : TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            alignment: isArabic ? Alignment.bottomRight : Alignment.bottomLeft,
            child: Text(discription,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
        ],
      ));
}

Widget roomImageTitle({required String ServicTitle}) {
  bool isArabic = Get.locale?.languageCode == 'ar';

  return Container(
    alignment: isArabic ? Alignment.bottomRight : Alignment.bottomLeft,
    margin: EdgeInsets.only(left: 5, top: 10, bottom: 5, right: 12),
    child: Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          ServicTitle,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

Widget imageRoom({
  required final String imagePath,
}) {
  return GestureDetector(
    onTap: () {
      Get.dialog(
        Dialog(
          backgroundColor: Colors.transparent,
          child: InteractiveViewer(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imagePath,
          height: 150,
          width: 180,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

Widget roomService(
    {required String nameservice,
    required String additional_fee,
    required String discription,
    required BuildContext context}) {
  return Container(
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.only(
      left: 4,
      right: 20,
      top: 15,
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 4),
          blurRadius: 6,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.drag_indicator,
                            size: 28, color: Color.fromARGB(239, 7, 86, 152)),
                        SizedBox(width: 1),
                        Text(
                          "nameservice".tr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      nameservice,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(width: 15),
            Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 3)),
                Text(
                  "additional_fee".tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  r'$' "${additional_fee}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Text(
                  "Discription".tr,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  discription,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget roomServicTitle({required String ServicTitle}) {
  return Container(
    margin: EdgeInsets.only(left: 5, top: 10, bottom: 5, right: 12),
    child: Column(
      children: [
        Text(
          ServicTitle,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

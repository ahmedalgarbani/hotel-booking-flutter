import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/views/screens/roomdetails/roomdetails.dart';

Widget detaielsHotel({required String name}) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
      color: Colors.white,
    ),
    child: Stack(
      children: [
        Column(
          children: [
            ClipRRect(
              child: Image.asset(
                "assets/Screenshot 2025-01-12 153603.png",
                width: double.infinity,
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appbarIcons(Icons.grid_view),
              appbarIcons(Icons.notification_add_outlined),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============== the discription ===============================================================

Widget descriptonhotel({
  required String hotel_name,
  required String location,
}) {
  return Container(
    margin: EdgeInsets.only(left: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [
          Colors.lightBlue.withOpacity(0.1),
          Colors.blueAccent.withOpacity(0.1),
          Colors.lightBlueAccent.withOpacity(0.6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("$hotel_name ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow,
              size: 18,
            ),
            Icon(
              Icons.star,
              color: Colors.yellow,
              size: 18,
            ),
            Icon(
              Icons.star,
              color: Colors.yellow,
              size: 18,
            ),
            Icon(
              Icons.star,
              color: Colors.yellow,
              size: 18,
            ),
            Text("(172)",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey[200])),
          ],
        ),
        Row(
          children: [
            Icon(Icons.location_on, color: Colors.grey, size: 20),
            Text(location,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ],
        ),
      ],
    ),
  );
}

Widget appbarIcons(IconData iconData) {
  return Container(
    margin: EdgeInsets.all(35),
    height: 35,
    width: 35,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: Colors.white,
    ),
    child: Icon(iconData, size: 24, color: Colors.black),
  );
}

//======================= the kinds of rooms===================================================
Widget roomImage(
    {required final String imagePath,
    required String roomtype,
    required String hotelname,
    required String default_capacity,
    required double base_price,
    required modelRoomm room,
    required final int id,
    required final int indexhotel,
    required final int roomindex,
    required BuildContext context}) {
final ConfirmController bookingController = Get.find<ConfirmController>();

  return InkWell(
    onTap: () {
      // bookingController.fetchHotelRoomName(
      //     hotelname: hotelname, roomName: room.name);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomDetails(
              room: room,
              indexhotel: indexhotel,
              roomindex: roomindex,
              id: id,
              room_id: room.id,
            ),
          ));
    },
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 20, bottom: 10),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(1, 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imagePath,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roomtype,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.person, size: 16.0, color: Colors.grey),
                        SizedBox(width: 4.0),
                        Text("$default_capacity /'person'",
                            style: TextStyle(color: Colors.grey)),
                        SizedBox(width: 16.0),
                        Icon(Icons.square_foot, size: 16.0, color: Colors.grey),
                        SizedBox(width: 4.0),
                        Text("", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      r'$' "$base_price./day",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget iconsdetail(IconData icon) {
  return Container(
    child: Icon(icon),
  );
}

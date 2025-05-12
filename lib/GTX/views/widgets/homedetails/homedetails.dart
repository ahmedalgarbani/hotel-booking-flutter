import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/views/screens/mainpagescreens/homepage.dart';
import 'package:hotels/GTX/views/screens/roomdetails/roomdetails.dart';

// ============== the discription ===============================================================

Widget iamgeHotel({
  required String image,
  required String hotel_name,
  required String location,
}) {
  return Stack(
    children: [
      Container(
        child: Column(
          children: [
            Image.network(image),
          ],
        ),
      ),
      Positioned(
        bottom: 10,
        child: Container(
          margin: EdgeInsets.only(left: 8,right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hotel_name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize:22,
                    ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
          
                Icon(Icons.location_on,color: Colors.grey,),
                Text(location,
                style: TextStyle(
                    color: Colors.white,
                    fontSize:18,
                    ),)
              ],)
            ],
          ),
        ),
      )
    ],
  );
}

Widget descriptonhotel({
  required String hotel_name,
  required String deicrption,
  required String location,
}) {
  return Container(
    margin: EdgeInsets.only(left: 2, right: 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Description".tr, style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          child: Text(
            "$deicrption",
          ),
        ),
      ],
    ),
  );
}

Widget appbarIcons(
    {required IconData iconData, required VoidCallback onPressed}) {
  return Container(
    margin: EdgeInsets.all(35),
    height: 35,
    width: 35,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: Colors.white,
    ),
    child: IconButton(
      icon: Icon(iconData, size: 24, color: Colors.black),
      onPressed: onPressed,
    ),
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
    required HotelsModel hotel,
    required final int id,
    required final int indexhotel,
    required final int roomindex,
    required BuildContext context}) {
  final ConfirmController bookingController = Get.find<ConfirmController>();

  return InkWell(
    onTap: () {
      // bookingController.fetchHotelRoomName(
      //     hotelname: hotelname, roomName: room.name);
      bookingController.amount.value = base_price.toString();
      bookingController.hotel_id.value = hotel.id.toString();
      bookingController.room_id.value = room.id.toString();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomDetails(
              room: room,
              indexhotel: indexhotel,
              roomindex: roomindex,
              id: id,
              room_id: room.id,
              hotel: hotel,
            ),
          ));
    },
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
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
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image),
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

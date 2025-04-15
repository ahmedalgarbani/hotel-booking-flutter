import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/database.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/views/widgets/homedetails/homedetails.dart';

class Detailshomescreen extends StatefulWidget {
  final HotelsModel hotel;

  final int indexhotel;
  final int id;

  Detailshomescreen(
      {required this.indexhotel, required this.hotel, required this.id});

  @override
  State<Detailshomescreen> createState() => _DetailshomescreenState();
}

class _DetailshomescreenState extends State<Detailshomescreen> {
  DateTime selectdDate = DateTime.now();
  SqlDb sqlDb = SqlDb();
  final ConfirmController bookingController = Get.find<ConfirmController>();

  @override
  void initState() {
    super.initState();
    // readImageRoom();
    Get.find<Hotelinfo>().loadHotelRoomsById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.hotel.rooms.first.name);
    print("widget.hotel.rooms.first.name");
    print("widget.hotel.rooms.first.name");

    return Scaffold(
      body: SingleChildScrollView(
        child: GetX<Hotelinfo>(
          builder: (control) => Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  detaielsHotel(name: ''),
                  Positioned(
                      top: 230,
                      right: 0,
                      left: 0,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: SizedBox(
                          child: descriptonhotel(
                              hotel_name: widget.hotel.name,
                              location: control.hotelsList.first.location),
                        ),
                      )),
                  Positioned(
                    top: 340,
                    right: 0,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      height: 400,
                      width: double.infinity,
                      child: Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 8),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Rooms Type",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                            SizedBox(
                              height: 350,
                              width: double.infinity,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: control
                                    .hotelsList[widget.indexhotel].rooms.length,
                                itemBuilder: (context, index) {
                                  final room = control.hotelroom[index];


                                  // OnTap(){
                                  //    bookingController.fetchHotelRoomName(hotelname:control.hotelsList[widget.indexhotel].name, roomName: room.name);

                                  // }
                                  print(
                                      "${control.hotelsList[widget.indexhotel].rooms}");
                                  final namehotel = control
                                      .hotelsList[widget.indexhotel].name;
                                  // room.roomImages[index].

                                  control.hotelsList[widget.indexhotel].name;
                                  print("rooom");
                                  print("rooom");
                                  print("rooom");
                                  // print(room[index].name);

                                  // final room = widget.hotel.rooms[index];
                                  final mainImage = room.roomImages.firstWhere(
                                      (img) => img.isMain,
                                      orElse: () => room.roomImages.first);

                                  return roomImage(
                                    imagePath: mainImage.imageUrl,
                                    roomtype: room.name,
                                    context: context,
                                    default_capacity:
                                        room.defaultCapacity.toString(),
                                    base_price: room.basePrice,
                                    room: room,
                                    id: widget.id,
                                    indexhotel: widget.indexhotel,
                                    roomindex: index,
                                    hotelname: namehotel,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

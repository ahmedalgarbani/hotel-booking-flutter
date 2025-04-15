import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/database.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/views/widgets/homedetails/confirmbooking.dart';
import 'package:hotels/GTX/views/widgets/roomdetails/roomdetails.dart';

class RoomDetails extends StatefulWidget {
  final modelRoomm room;
  final int indexhotel;
  final int id;
  final int room_id;
  final int roomindex;

  RoomDetails({
    super.key,
    required this.room,
    required this.indexhotel,
    required this.roomindex,
    required this.id,
    required this.room_id,
  });

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  final Hotelinfo hotroomm = Hotelinfo();
  final ConfirmController get_addtion_fee = Get.find<ConfirmController>();

 

  
  @override
  void initState() {
    super.initState();
    Get.find<Hotelinfo>().loadHotelRoomsServiceById(widget.room.id);
    Get.find<Hotelinfo>().loadHotelRoomsImageById(widget.room_id);
    Get.find<Hotelinfo>().loadHotelRoomsById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final mainImag = widget.room.roomImages.firstWhere((img) => img.isMain,
        orElse: () => widget.room.roomImages.first);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Icon(Icons.share, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: GetX<Hotelinfo>(builder: (controll) {
          final roomImages = controll
              .hotelsList[widget.indexhotel].rooms[widget.roomindex].roomImages;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              roomImageHotel(
                  mainImage: mainImag,
                  locationHotel:
                      controll.hotelsList[widget.indexhotel].location,
                  nameHotel: controll.hotelsList[widget.indexhotel].name),
              roomTypeTitle(ServicTitle: 'Room Type'),
              Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.1, 0.1),
                    blurRadius: 0.1,
                    blurStyle: BlurStyle.solid,
                    spreadRadius: 0.5,
                  )
                ]),
                child: Column(
                  children: [
                    nameRoomType(name: widget.room.name),
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          final room = controll.hotelroom[index];
                          return detailroom(room: widget.room);
                        },
                      ),
                    ),
                    titleDiscriptionroom(discription: widget.room.description),
                  ],
                ),
              ),
              roomServicTitle(ServicTitle: 'Our Services :'),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controll.hotelroomService.length,
                  itemBuilder: (context, index) {

                    
                  
                    final roomservice = controll.hotelroomService[index];

                    return InkWell(
                     onTap: (){
                      get_addtion_fee.additional_fee.value=controll.hotelroomService[index].additionalFee.toString();
                      print(get_addtion_fee.additional_fee.value);
                     },
                      child: roomService(
                          nameservice: roomservice.name,
                          additional_fee: roomservice.additionalFee.toString(),
                          discription: roomservice.description),
                    );
                  },
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    roomImageTitle(ServicTitle: "The Gellary"),
                    SizedBox(
                      height: 300,
                      child: GridView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2 / 2,
                          mainAxisSpacing: 40,
                          crossAxisSpacing: 20,
                        ),
                        itemCount: controll.hotelroomimage.length,
                        itemBuilder: (context, index) {
                          return imageRoom(
                              imagePath:
                                  controll.hotelroomimage[index].imageUrl);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          );
        }),
      ),
      bottomNavigationBar: GetX<ConfirmController>(
        builder: (controllprice) => ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Price",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: r'$' "${controllprice.amount.value}",
                            style: TextStyle(
                                color: Color.fromARGB(239, 7, 86, 152),
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: " /night",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GetX<ConfirmController>(
                  builder: (controller) => ElevatedButton(
                    onPressed: () {
                      // controller.isLoading.value
                      //   ? null
                      //   : () async
                      //       await
                      //
                      
                      controller.updateConfirmBooking(
                        indexhotel: widget.indexhotel,
                        indexroom: widget.roomindex,
                      );

                      bottunSheet(
                        context: context,
                        indexhotel: widget.indexhotel,
                        id: widget.id,
                        indexroom: widget.roomindex,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Book Now"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

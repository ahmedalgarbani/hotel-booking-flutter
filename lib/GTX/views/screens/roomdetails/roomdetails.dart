import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/database.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/views/widgets/ConnectionCheckWidget/ConnectionCheckWidget.dart';
import 'package:hotels/GTX/views/widgets/homedetails/buildRatingButtons.dart';
import 'package:hotels/GTX/views/widgets/homedetails/confirmbooking.dart';
import 'package:hotels/GTX/views/widgets/roomdetails/rievewRoom.dart';
import 'package:hotels/GTX/views/widgets/roomdetails/roomdetails.dart';

class RoomDetails extends StatefulWidget {
  final modelRoomm room;
  final int indexhotel;
  final int id;
  final int room_id;
  final int roomindex;
  final HotelsModel hotel;

  RoomDetails({
    super.key,
    required this.room,
    required this.indexhotel,
    required this.roomindex,
    required this.id,
    required this.room_id,
    required this.hotel,
  });

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  final Hotelinfo hotroomm = Hotelinfo();
  final ConfirmController get_addtion_fee = Get.find<ConfirmController>();
  final NetworkController connectivityController =
      Get.find<NetworkController>();

  @override
  void initState() {
    super.initState();
    print("widget.room_id");
    print(widget.room_id);
    Get.find<Hotelinfo>().loadHotelRoomsServiceById(widget.room.id);
    Get.find<Hotelinfo>().loadHotelRoomsImageById(widget.room_id);
    Get.find<Hotelinfo>().loadHotelRoomsById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final mainImag = widget.room.roomImages.isNotEmpty
        ? widget.room.roomImages.firstWhere(
            (img) => img.isMain,
            orElse: () => widget.room.roomImages.first,
          )
        : null;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("Details Room"),
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
          // final roomImages = controll.hotelroom[widget.id].roomImages;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: roomImageHotel(
                    mainImage: mainImag?.imageUrl ?? "",
                    locationHotel: widget.hotel.location,
                    nameHotel: widget.hotel.name),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height:controll.hotelroomimage.isEmpty? 30:150,

                      child: controll.hotelroomimage.isEmpty
                      ? Center(
                        child: Text(
                          'لا توجد صور  متاحة حالياً',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : 
                      
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        // physics: NeverScrollableScrollPhysics(),
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
              roomServicTitle(ServicTitle: 'Our Services :'.tr),
              SizedBox(
                height:controll.hotelroomService.isEmpty ?30: 150,
                child: controll.hotelroomService.isEmpty
                    ? Center(
                        child: Text(
                          'لا توجد خدمات إضافية متاحة حالياً',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controll.hotelroomService.length,
                        itemBuilder: (context, index) {
                          final roomservice = controll.hotelroomService[index];
                          return InkWell(
                            onTap: () {
                              final serviceId = roomservice.id;

                              if (!get_addtion_fee.extraServices
                                  .contains(serviceId)) {
                                get_addtion_fee.extraServices.add(serviceId);
                                showServiceAddedDialog(context,
                                    "it Has Add The Sevice", roomservice.name);
                                print(' تمت إضافة الخدمة $serviceId');
                              } else {
                                get_addtion_fee.extraServices.remove(serviceId);
                                showServiceAddedDialog(
                                    context,
                                    "it Has Delete The Sevice",
                                    roomservice.name);
                                print(' تمت إزالة الخدمة $serviceId');
                              }

                              final additionalFeeValue =
                                  roomservice.additionalFee;

                              if (!get_addtion_fee.additional_fee
                                  .contains(additionalFeeValue)) {
                                get_addtion_fee.additional_fee
                                    .add(additionalFeeValue!);
                                print(
                                    ' تمت إضافة الرسوم الإضافية $additionalFeeValue');
                              } else {
                                get_addtion_fee.additional_fee
                                    .remove(additionalFeeValue);
                                print(
                                    ' تمت إزالة الرسوم الإضافية $additionalFeeValue');
                              }

                              print(get_addtion_fee.additional_fee.value);
                            },
                            child: roomService(
                              nameservice: roomservice.name,
                              additional_fee:
                                  roomservice.additionalFee.toString(),
                              discription: roomservice.description,
                              context: context,
                            ),
                          );
                        },
                      ),
              ),
              // Container(
              //   child: Column(
              //     children: [
              //       SizedBox(
              //         height: 20,
              //         child: GridView.builder(
              //           shrinkWrap: true,
              //           // physics: NeverScrollableScrollPhysics(),
              //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 3,
              //             childAspectRatio: 2 / 2,
              //             mainAxisSpacing: 50,
              //             crossAxisSpacing: 30,
              //           ),
              //           itemCount: controll.hotelroomimage.length,
              //           itemBuilder: (context, index) {
              //             return imageRoom(
              //                 imagePath:
              //                     controll.hotelroomimage[index].imageUrl);
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              roomTypeTitle(ServicTitle: 'Room Type'.tr),
              Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    boxShadow: [
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
                          return detailroom(
                            room: room,
                          );
                        },
                      ),
                    ),
                   
                    titleDiscriptionroom(discription: widget.room.description),
                  ],
                ),
              ),

              SizedBox(
                height: 40,
              ),

               reviewRoom(hootelid: widget.hotel.id, roomid: widget.room_id),
            ],
          );
        }),
      ),
      bottomNavigationBar: GetX<ConfirmController>(
        builder: (controllprice) => ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Theme.of(context).colorScheme.secondary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Price".tr,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: r'$' "${controllprice.totalPrice.toString()}",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: " /night",
                            style: TextStyle(fontSize: 16),
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

                      // controller.updateConfirmBooking(
                      //   indexhotel: widget.id,
                      //   indexroom: widget.room_id,
                      // );

                      bottunSheet(
                        context: context,
                        indexhotel: widget.indexhotel,
                        id: widget.id,
                        indexroom: widget.room_id,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Book Now".tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showServiceAddedDialog(
      BuildContext context, String serviceName, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('$message $serviceName'),
          actions: [
            // TextButton(
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            //   child: Text('تم'),
            // ),
          ],
        );
      },
    );

    Future.delayed(Duration(seconds: 2), () {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
    });
  }
}

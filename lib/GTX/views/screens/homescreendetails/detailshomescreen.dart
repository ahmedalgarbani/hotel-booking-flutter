import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/database.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/HotelReviewController.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/controller/search_controller.dart';
import 'package:hotels/GTX/views/widgets/ConnectionCheckWidget/ConnectionCheckWidget.dart';
import 'package:hotels/GTX/views/widgets/homedetails/buildRatingButtons.dart';
import 'package:hotels/GTX/views/widgets/homedetails/homedetails.dart';
import 'package:hotels/GTX/views/widgets/homedetails/reivewDetail.dart';
import 'package:hotels/GTX/views/widgets/homedetails/sericehotel.dart';

class Detailshomescreen extends StatefulWidget {
  final HotelsModel hotel;
  final int id;
  final int searchoteid;
  final bool fromSearch;

  Detailshomescreen({
    required this.hotel,
    required this.id,
    required this.searchoteid,
    this.fromSearch = false,
  });

  @override
  State<Detailshomescreen> createState() => _DetailshomescreenState();
}

final reviewTextController = TextEditingController();

class _DetailshomescreenState extends State<Detailshomescreen> {
  DateTime selectdDate = DateTime.now();
  SqlDb sqlDb = SqlDb();
  final ConfirmController bookingController = Get.find<ConfirmController>();
 
  final NetworkController connectivityController =
      Get.find<NetworkController>();
  final SearchHotelController hotelInfosearch =
      Get.find<SearchHotelController>();
  // final HotelReviewController ratingReview = Get.find<HotelReviewController>();

  @override
  void initState() {
    super.initState();
    final hotelInfoController = Get.find<Hotelinfo>();

    if (widget.fromSearch) {
      hotelInfosearch.loadAvailableRoomsById(widget.searchoteid);
    } else {
      hotelInfoController.loadHotelRoomsById(widget.id);
      // hotelInfoController.loadHotelreviewHotelById(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = Get.locale?.languageCode == 'ar';

    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: GetX<Hotelinfo>(
          builder: (control) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Increased margin
              iamgeHotel(image: widget.hotel.image, hotel_name: widget.hotel.name, location: widget.hotel.location),
    
              SizedBox(
                height: (widget.fromSearch
                        ? hotelInfosearch.Servicehotelssearch.isNotEmpty
                        : control.Servicehotel.isNotEmpty)
                    ? 50
                    : 30,
                child: Builder(
                  builder: (_) {
                    final serviceList = widget.fromSearch
                        ? hotelInfosearch.Servicehotelssearch
                        : control.Servicehotel;
    
                    if (serviceList.isNotEmpty) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: serviceList.length,
                        itemBuilder: (context, index) {
                          final roomserviceHotel = serviceList[index];
                          return serviceHotel(
                              nameServiceHotel: roomserviceHotel.name);
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          "لا توجد بيانات",
                          style: TextStyle(),
                        ),
                      );
                    }
                  },
                ),
              ),
    
              // وصف الفندق
              Padding(
                padding: const EdgeInsets.all(16.0), // Added more padding
                child: descriptonhotel(
                  hotel_name: widget.hotel.name,
                  location: widget.hotel.location,
                  deicrption: widget.hotel.description,
                ),
              ),
    
              SizedBox(height: 5),
              Container(
                  margin: EdgeInsets.only(left: 12, right: 12),
                  child: Text("Review Hotel".tr)),
    
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1, 
                  itemBuilder: (context, index) {
                    final reviews = widget.fromSearch
                        ? hotelInfosearch.reviewHotelSearch
                        : control.reviewHotel;
    
                    if (reviews.isEmpty) {
                      return Center(child: Text("لا توجد تقييمات بعد"));
                    }
    
                    double totalCleanliness = 0;
                    double totalService = 0;
                    double totalLocation = 0;
                    double totalValue = 0;
    
                    for (var review in reviews) {
                      totalCleanliness += review.ratingCleanliness;
                      totalService += review.ratingService;
                      totalLocation += review.ratingLocation;
                      totalValue += review.ratingValueForMoney;
                    }
    
                    int count = reviews.length;
    
                    return Row(
                      children: [
                        reviewDetail(
                            namerating: "الخدمة",
                            rating: (totalService / count).round()),
                        reviewDetail(
                            namerating: "الموقع",
                            rating: (totalLocation / count).round()),
                        reviewDetail(
                            namerating: "النظافة",
                            rating: (totalCleanliness / count).round()),
                        reviewDetail(
                            namerating: "القيمة مقابل المال",
                            rating: (totalValue / count).round()),
                      ],
                    );
                  },
                ),
              ),
    
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rooms Type".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        buildRating(id: widget.hotel.id),
                      ],
                    ),
                  ],
                ),
              ),
    
              SizedBox(height: 20),
              SizedBox(
                height: 400,
                child: Obx(() {
                  final isEmpty = widget.fromSearch
                      ? hotelInfosearch.hotelroomsearch.isEmpty
                      : control.hotelroom.isEmpty;
    
                  if (isEmpty) {
                    return Center(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.amber.shade100,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(
                            alignment: Alignment.center,
                            width: 300,
                            height: 220,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "😊",
                                  style: TextStyle(fontSize: 48),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "لا يتوفر أنواع غرف حالياً",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
    
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.fromSearch
                        ? hotelInfosearch.hotelroomsearch.length
                        : control.hotelroom.length,
                    itemBuilder: (context, index) {
                      final room = widget.fromSearch
                          ? hotelInfosearch.hotelroomsearch[index]
                          : control.hotelroom[index];
                      
                      final mainImage = room.roomImages.isNotEmpty
                          ? room.roomImages.firstWhere(
                              (img) => img.isMain,
                              orElse: () => room.roomImages.first,
                            )
                          : null;
                      
                      return roomImage(
                        imagePath: mainImage?.imageUrl ??
                            'assets/images/default_room.jpg',
                        roomtype: room.name,
                        context: context,
                        default_capacity: room.defaultCapacity.toString(),
                        base_price: room.basePrice,
                        room: room,
                        id: widget.id,
                        indexhotel: widget.id,
                        roomindex: index,
                        hotelname: room.name,
                        hotel: widget.hotel,
                      );
                    },
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

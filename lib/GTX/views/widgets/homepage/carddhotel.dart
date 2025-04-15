import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/views/screens/homescreendetails/detailshomescreen.dart';

// required String hotelName,
//   required String location,
//   required String price,
//   required final Uint8List? imagePath, // Nullable to handle missing images
//   required final int id,
Widget cardHotel({
  required BuildContext context,
  required int indexhotel,
  required HotelsModel hotel,
  required VoidCallback favorite,
  required VoidCallback toggleFavorite,
  required bool isFavorite,
}) {
  final Hotelinfo hotelInfo = Hotelinfo();
  return InkWell(
    onTap: () {
      print("indexhotellllhom");
      print("indexhotellllhom");
      print("indexhotellllhom");
      print("indexhotellllhom");
      print("indexhotellllhom");
      print("indexhotellllhom");
      
      print(indexhotel);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Detailshomescreen(
            indexhotel: indexhotel,
            hotel: hotel,
            id: hotel.id,
          ),
        ),
      );
    },
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 5,
            top: 10,
            right: 5,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(1, 1),
                    blurStyle: BlurStyle.solid,
                    spreadRadius: 2,
                    blurRadius: 5,
                    color: Colors.grey.withOpacity(0.2))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: hotel.image.isNotEmpty
                          ? Image.network(
                              hotel.image,
                              height: 150,
                              width: 180,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.broken_image),
                            )
                          : Text("Connect the internet to load"),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 150,
                    child: GestureDetector(
                      onTap: () async {
                        toggleFavorite();
                        favorite();
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(80),
                          border: Border.all(
                            color: Color.fromARGB(239, 7, 86, 152),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Color.fromARGB(239, 7, 86, 152) : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        
                        Text(
                          "hotelName : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          hotel.name,
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          hotel.location,
                          style: TextStyle(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description : "),
                        Text(hotel.description ,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget titleCard() {
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10, top: 11),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Popular Hotel",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          "See All",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}

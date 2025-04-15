import 'package:flutter/material.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';

Widget favoriteHotel(
    {required String hotelName,
    required String imagehotel,
    required String location,
    required VoidCallback deltefavorite,

      

}) {
  return Container(
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
                child: Image.network(
                  imagehotel,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                top: 12,
                left: 83,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80)),
                  child: IconButton(
                    padding: EdgeInsets.only(right: 1, top: 2),
                    icon: Icon(Icons.favorite,
                        color: Color.fromARGB(239, 7, 86, 152)),
                    onPressed: () async {
                      deltefavorite();

                    },
                  ),
                ))
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hotelName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    "location:",
                    style: TextStyle(),
                  ),
                  Text(
                    "$location ",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

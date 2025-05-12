import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/views/screens/homescreendetails/detailshomescreen.dart';
import 'package:hotels/GTX/views/showAllHotels/showAllhotels.dart';

import 'package:flutter/material.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
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
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Detailshomescreen(
            hotel: hotel,
            id: hotel.id,
            searchoteid: hotel.id,
          ),
        ),
      );
    },
    child: Card(
      color: Theme.of(context).colorScheme.secondary,
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 200,
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: hotel.image.isNotEmpty
                  ? Image.network(
                      hotel.image,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.broken_image),
                    )
                  : Container(
                      height: 120,
                      color: Colors.grey[300],
                      child: Center(
                        child: Text("No image",
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ),
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.only(right: 5, left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotel.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          hotel.location.split(' ').take(4).join(' ') + '...',
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[600]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      toggleFavorite();
                      favorite();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Color(0xFF273F46) : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    ),
  );
}

Widget imageNoConnection({
  required double width,
  required double height,
  required String imagepath,
}) {
  return Container(
    margin: EdgeInsets.all(5),
    child: SizedBox(
      width: width,
      child: Image.asset(
        imagepath,
        height: height,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget titleCard({
  required BuildContext context,
  required String titleText,
  required String seeAllText,
  required Widget navigateToPage,
}) {
  return Container(
    margin: const EdgeInsets.only(left: 10, right: 10, top: 11),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleText.tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => navigateToPage,
              ),
            );
          },
          child: Text(seeAllText.tr),
        )
      ],
    ),
  );
}

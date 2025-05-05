import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/views/screens/homescreendetails/detailshomescreen.dart';
import 'package:hotels/GTX/views/screens/nearbyhotelscreen/NearbyHotelsScreen%20.dart';

Widget hotelCard(
    {required BuildContext context,
    required String image,
    required String name,
    required HotelsModel hotel,
    required int id,
    
    required String hotelLocation}) {
  return Card(
    color: Theme.of(context).colorScheme.secondary,
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.broken_image),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      hotelLocation,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < 1 ? Icons.star : Icons.star_border,
                      size: 16,
                      color: Colors.amber,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "price",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(
                          Detailshomescreen(
                            
                            hotel: hotel,
                            id: hotel.id,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(),
                      child: Text("احجز الآن"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget titleNearby({required BuildContext context}) {
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10),
    alignment: Alignment.bottomLeft,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Near By Hotel :".tr,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NearbyHotelsScreen(),
                ),
              );
            }, child: Text(
          "See All :".tr,
          style: TextStyle(color: Colors.grey),
        ),
        ),
        
      ],
    ),
  );
}

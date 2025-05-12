// lib/GTX/views/widgets/review_hotel_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/views/screens/homescreendetails/detailshomescreen.dart';

class ReviewHotelCard extends StatelessWidget {
  final HotelsModel hotel;
  final String image;
  final String name;
  final double rating;
  final String location;

  const ReviewHotelCard({
    Key? key,
    required this.hotel,
    required this.image,
    required this.name,
    required this.rating,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: InkWell(
        onTap: () => Get.to(() => Detailshomescreen(
              hotel: hotel,
              id: hotel.id,
              searchoteid: hotel.id,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                image,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    size: 16,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(location, style: const TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}

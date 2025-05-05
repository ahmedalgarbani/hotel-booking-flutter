import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteCard extends StatefulWidget {
  final String hotelName;
  final String imagehotel;
  final String location;
  final String description;
  final VoidCallback deltefavorite;

  const FavoriteCard({
    super.key,
    required this.hotelName,
    required this.imagehotel,
    required this.location,
    required this.description,
    required this.deltefavorite,
  });

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(left: 5, top: 10, right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 1),
              blurStyle: BlurStyle.solid,
              spreadRadius: 2,
              blurRadius: 5,
              color: Colors.grey.withOpacity(0.2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.imagehotel,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 120,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.only(right: 1, top: 2),
                      icon: const Icon(Icons.favorite,
                          color: Color.fromARGB(239, 7, 86, 152)),
                      onPressed: widget.deltefavorite,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hotelName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey),
                      Expanded(
                        child: Text(
                          widget.location.split(' ').take(4).join(' ') + '...',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Description :'.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    widget.description.split(' ').take(4).join(' ') + '...',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


Widget buildSearchBar({
  required BuildContext context,
  required Function(String) onChanged, // ← أضف هذا
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Theme.of(context).inputDecorationTheme.fillColor ?? Colors.grey[200],
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextField(
      onChanged: onChanged, // ← استخدم الباراميتر
      decoration: const InputDecoration(
        hintText: "Search...",
        border: InputBorder.none,
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        suffixIcon: Icon(Icons.tune, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 15),
      ),
    ),
  );
}

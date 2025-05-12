import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/views/screens/homescreendetails/detailshomescreen.dart';

class FavoriteCard extends StatefulWidget {
  final String hotelName;
  final String imagehotel;
  final String location;
  final String description;
  final VoidCallback deltefavorite;
final HotelsModel hotel;
  const FavoriteCard({
    super.key,
    required this.hotel,
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
    return 
   GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Detailshomescreen(
            hotel:widget.hotel,
            id: widget.hotel.id,
            searchoteid: widget.hotel.id,
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
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: widget.hotel.image.isNotEmpty
                    ? Image.network(
                        widget.hotel.image,
                        height: 10,
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
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.only(right: 5, left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.hotel.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.hotel.location.split(' ').take(4).join(' ') + '...',
                        style:
                            TextStyle(fontSize: 13, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(80),
                                    ),
                                    child:  
                                    IconButton(
                  padding: const EdgeInsets.only(right: 1, top: 2),
                  icon: const Icon(Icons.favorite,
                      color: Color.fromARGB(239, 7, 86, 152)),
                  onPressed: widget.deltefavorite,
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
}





Widget buildSearchBar({
  required BuildContext context,
  required Function(String) onChanged,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Theme.of(context).inputDecorationTheme.fillColor ?? Colors.grey[200],
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextField(
      onChanged: onChanged, 
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




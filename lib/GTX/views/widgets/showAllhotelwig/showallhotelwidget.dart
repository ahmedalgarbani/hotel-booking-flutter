import 'package:flutter/material.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/views/screens/homescreendetails/detailshomescreen.dart';

class Showallhotelwidget extends StatefulWidget {
  final BuildContext context;
  final int indexhotel;
  final HotelsModel hotel;
  final VoidCallback favorite;
  final VoidCallback toggleFavorite;
  final bool isFavorite;

   Showallhotelwidget({
    required this.context,
    required this.indexhotel,
    required this.hotel,
    required this.favorite,
    required this.toggleFavorite,
    required this.isFavorite,
  });

  @override
  State<Showallhotelwidget> createState() => _ShowallhotelwidgetState();
}

class _ShowallhotelwidgetState extends State<Showallhotelwidget> {
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
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.toggleFavorite();
                      widget.favorite();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                       widget. isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: widget.isFavorite ? Color(0xFF273F46) : Colors.grey,
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
}

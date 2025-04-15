import 'package:flutter/material.dart';
import 'package:hotels/GTX/views/screens/searchscreens/searchhotelscreen.dart';

Widget searchhotel(
  BuildContext context,
  GlobalKey<ScaffoldState> key,
) {
  return Container(
    width: double.infinity, 
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withAlpha((0.1 * 255).toInt()), 
          blurRadius: 5,
          spreadRadius: 1,
        )
      ],
    ),
    child: 
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
           
            children: [
              IconButton(
                onPressed: () => key.currentState?.openDrawer(),
                icon: const Icon(Icons.menu,color:Color.fromARGB(220, 7, 86, 152 ,)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // ✅ تحسين المحاذاة
                children: [
                  Text("Ahmed", style: TextStyle(color: Colors.grey[500])),
                  const Text(
                    "Al-jarbani",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // ✅ جعل الحواف دائرية بالكامل
            border: Border.all(color: Colors.grey),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Searchhotelscreen(),
                ),
              );
            },
            icon: const Icon(Icons.search,color:Color.fromARGB(220, 7, 86, 152 ,)),
          ),
        ),
      ],
    ),
  
  );
}

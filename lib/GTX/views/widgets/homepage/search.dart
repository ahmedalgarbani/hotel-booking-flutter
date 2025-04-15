// import 'package:flutter/material.dart';

// class Search extends StatefulWidget {
//   const Search({super.key});

//   @override
//   State<Search> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<Search> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             //the seconde section
//             _searchA(),
//             SizedBox(
//               height: 150,
//             ),
//             _ourHotel(),
//             SizedBox(
//               height: 20,
//             ),
//             _buildHorizontalHotelList()
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget _fun(String? name, bool isSelected) {
//   return Row(
//     children: [
//       Container(
//         decoration: BoxDecoration(
//             // color: isSelected ? Colors.greenAccent : Colors.red,
//             borderRadius: BorderRadius.circular(20)),
//         child: TextButton(
//           onPressed: () {},
//           child: Text(name!),
//           style: TextButton.styleFrom(
//             foregroundColor:
//                 isSelected ? Colors.greenAccent : Colors.red, // اللون النصي
//           ),
//         ),
//       ),
//     ],
//   );
// }

// Widget _searchA() {
//   return Container(
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.blue, Colors.blueAccent],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20))),
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Column(
//             children: [
//               Padding(padding: EdgeInsets.all(20)),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       Padding(padding: EdgeInsets.only(left: 30)),
//                       Text(
//                         "Hello,Ahmed",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       Text("Let's Start Discove",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                   Padding(
//                       padding: EdgeInsets.only(
//                         right: 30,
//                       ),
//                       child: ClipOval(
//                         child: Image.asset(
//                           "assets/IMG_0150.JPG",
//                           fit: BoxFit.cover,
//                           height: 50,
//                           width: 50,
//                         ),
//                       ))
//                 ],
//               )
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 150.0),
//           ),
//           Positioned(
//               top: 180,
//               left: 0,
//               right: 0,
//               child: Container(
//                 height: 250,
//                 margin: EdgeInsets.symmetric(horizontal: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(color: Colors.grey.shade300, width: 1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   children: [
//                     // Top Tabs
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _fun("All", true),
//                           _fun("Hotel", false),
//                           _fun("Villa", false),
//                         ],
//                       ),
//                     ),
//                     // Location
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20.0, vertical: 10.0),
//                       child: Row(
//                         children: [
//                           Icon(Icons.location_on, color: Colors.grey),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               "Sana'a ,BeatBus",
//                               style: TextStyle(
//                                   color: Colors.grey.shade700, fontSize: 16),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Check-in & Check-out Dates
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20.0, vertical: 10.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           _dateField(Icons.calendar_today, "10, Apr 2023"),
//                           _dateField(Icons.calendar_today, "12, Apr 2023"),
//                         ],
//                       ),
//                     ),
//                     // Search Button
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20.0, vertical: 10.0),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               const Color.fromARGB(255, 98, 240, 169),
//                           minimumSize: Size(double.infinity, 50),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(35),
//                           ),
//                         ),
//                         onPressed: () {
//                         },
//                         child: Text(
//                           "Search",
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//         ],
//       ));
// }

// Widget _dateField(IconData icon, String date) {
//   return Row(
//     children: [
//       Icon(icon, color: Colors.grey),
//       SizedBox(width: 8),
//       Text(
//         date,
//         style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
//       ),
//     ],
//   );
// }

// Widget _ourHotel() {
//   return Container(
//     margin: EdgeInsets.all(8),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           "Popular Hotel",
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         Text(
//           "See All",
//           style: TextStyle(color: Colors.grey),
//         ),
//       ],
//     ),
//   );
// }
// // Widget _cardHotel() {
// //   return Builder(
// //     builder: (context) {
// //       return SingleChildScrollView(
// //         scrollDirection: Axis.horizontal,
// //         child: Container(

// //           decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(8),
// //               border: Border.all(
// //                 color: Colors.blue,
// //               ),
// //               boxShadow: [
// //                 BoxShadow(
// //                   offset: Offset(1, 5),
// //                   color: Colors.grey,
// //                   blurRadius: 10,
// //                   blurStyle: BlurStyle.normal,
// //                   spreadRadius: 4,
// //                 )
// //               ]),
// //           child: Card(
// //             elevation: 10,
// //             child: Column(
// //               children: [
// //                 ClipRRect(
// //                   child: Image.asset("assets/hotel.png"),
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text("hotel Sana'a"),
// //                     Row(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Icon(
// //                           Icons.location_city_outlined,
// //                           color: Colors.green,
// //                         ),
// //                         Text("Sana'a "),
// //                       ],
// //                     ),
// //                     Text(r"$660")
// //                   ],
// //                 )
// //               ],
// //             ),
// //           ),
// //         ),
// //       );
// //     }
// //   );
// // }

// Widget _cardHotel(
//     String hotelName, String location, String price, String imagePath) {
//   return Container(
//     width: 200, // تحديد العرض
//     margin: const EdgeInsets.symmetric(horizontal: 11),
//     // مسافة بين العناصر
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(8),
//       border: Border.all(
//         color: Colors.white,
//       ),
//       boxShadow: [
//         const BoxShadow(
//           offset: Offset(1, 5),
//           color: Colors.grey,
//           blurRadius: 10,
//           blurStyle: BlurStyle.normal,
//           spreadRadius: 0,
//         )
//       ],
//     ),
//     child: Card(
//       elevation: 10,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.asset(
//               imagePath,
//               fit: BoxFit.cover,
//               height: 100,
//               width: double.infinity,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   hotelName,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.location_on,
//                       color: Colors.green,
//                     ),
//                     Text(location),
//                   ],
//                 ),
//                 Text(
//                   price,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.black87),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

// Widget _buildHorizontalHotelList() {
//   final List<Map<String, String>> hotelData = [
//     {
//       "name": "Hotel Sana'a",
//       "location": "Sana'a",
//       "price": r"$660",
//       "imagePath": "assets/hotel.png",
//     },
//     {
//       "name": "Hotel Kitab",
//       "location": "AL-garyai",
//       "price": r"$850",
//       "imagePath": "assets/hotel.png",
//     },
//     {
//       "name": "Hotel IBB",
//       "location": "ALmadainah",
//       "price": r"$500",
//       "imagePath": "assets/hotel.png",
//     },
//     {
//       "name": "Hotel IBB",
//       "location": "ALmadainah",
//       "price": r"$500",
//       "imagePath": "assets/hotel.png",
//     },
//     {
//       "name": "Hotel IBB",
//       "location": "ALmadainah",
//       "price": r"$500",
//       "imagePath": "assets/hotel.png",
//     },
//   ];

//   return SizedBox(
//     height: 200, // تحديد ارتفاع القائمة
//     child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: hotelData.length,
//       itemBuilder: (context, index) {
//         return _cardHotel(
//           hotelData[index]["name"]!,
//           hotelData[index]["location"]!,
//           hotelData[index]["price"]!,
//           hotelData[index]["imagePath"]!,
//         );
//       },
//     ),
//   );
// }

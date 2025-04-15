
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
// import 'package:hotels/GTX/Models/show_hotel_model.dart';
// import 'package:hotels/GTX/controller/search_controller.dart';
// import 'package:hotels/GTX/views/screens/homescreendetails/detailshomescreen.dart';

// Widget optionButtonDate(IconData icon, String label, context) {
//   return ElevatedButton.icon(
//     onPressed: () {
//       bottomSheet(context: context);
//     },
//     icon: Icon(icon, color: Color.fromARGB(239, 7, 86, 152)),
//     label: Text(label, style: TextStyle(color: Colors.black)),
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.grey[300],
//       padding: EdgeInsets.symmetric(vertical: 14),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//     ),
//   );
// }

// Widget cardSearch(
//     {
//     required int indexhotel,
//     required HotelsModel hotel,
//     required modelRoomm room,
//     required bool iselect,
//     required VoidCallback? deletfun,
//     required dynamic id,
//     required BuildContext context}) {
//   return InkWell(
//     onTap: () {
//       print("indexhotellll");
//       print("indexhotellll");
//       print("indexhotellll");
//       print("indexhotellll");
//       print("indexhotellll");
//       print("indexhotellll");
//       print("indexhotellll");
//       print(indexhotel);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Detailshomescreen(
//             indexhotel: indexhotel,
//             hotel: hotel,
//             id: hotel.id,
//           ),
//         ),
//       );
//     },
//     child: Column(
//       children: [
//         Container(
//           margin: EdgeInsets.only(
//             left: 5,
//             top: 10,
//             right: 5,
//           ),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                     offset: Offset(1, 1),
//                     blurStyle: BlurStyle.solid,
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     color: Colors.grey.withOpacity(0.2))
//               ]),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.all(5),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: hotel.image.isNotEmpty
//                           ? Image.network(
//                               hotel.image,
//                               height: 150,
//                               width: 180,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) =>
//                                   Icon(Icons.broken_image),
//                             )
//                           : Text("Connect the internet to load"),
//                     ),
//                   ),
//                   // Positioned(
//                   //   top: 10,
//                   //   left: 150,
//                   //   child: GestureDetector(
//                   //     onTap: () async {
//                   //       // toggleFavorite();
//                   //       // favorite();
//                   //     },
//                   //     child: Container(
//                   //       width: 35,
//                   //       height: 35,
//                   //       decoration: BoxDecoration(
//                   //         color: Colors.white,
//                   //         borderRadius: BorderRadius.circular(80),
//                   //         border: Border.all(
//                   //           color: Color.fromARGB(239, 7, 86, 152),
//                   //           width: 2,
//                   //         ),
//                   //       ),
//                   //       child: Center(
//                   //         child: Icon(
//                   //           isFavorite ? Icons.favorite : Icons.favorite_border,
//                   //           color: Color.fromARGB(239, 7, 86, 152),
//                   //         ),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       hotel.name,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       hotel.location,
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           room.defaultCapacity.toString(),
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           r"per Night",
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Future<void> bottomSheet({
//   required BuildContext context,
// }) {
//   return showModalBottomSheet(
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
//     ),
//     isScrollControlled: true,
//     builder: (ctx) => Padding(
//       padding: const EdgeInsets.all(30),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             GetX<SearchHotelController>(
//               builder: (controller) => Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Room", style: TextStyle(fontSize: 16)),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 8),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           children: [
//                             IconButton(
//                               onPressed: controller.decrementCounter,
//                               icon: Icon(Icons.remove),
//                             ),
//                             Text(controller.countersroom.value.toString()),
//                             IconButton(
//                               onPressed: controller.increament,
//                               icon: Icon(Icons.add),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Guest", style: TextStyle(fontSize: 16)),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 8),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           children: [
//                             IconButton(
//                               onPressed: controller.decrementCounterQuests,
//                               icon: Icon(Icons.remove),
//                             ),
//                             Text(controller.counterQuest.value.toString()),
//                             IconButton(
//                               onPressed: controller.incrementCounterQuests,
//                               icon: Icon(Icons.add),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 30),

//                   // زر المتابعة
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         padding: EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       child: Text(
//                         "Continue",
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

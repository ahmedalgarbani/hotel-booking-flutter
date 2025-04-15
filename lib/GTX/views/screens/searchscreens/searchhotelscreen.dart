import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/search_controller.dart';
import 'package:hotels/GTX/views/screens/homescreendetails/detailshomescreen.dart';

class Searchhotelscreen extends StatelessWidget {
  final SearchHotelController searchController =
      Get.find<SearchHotelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Color.fromARGB(239, 7, 86, 152),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(239, 7, 86, 152),
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Text("Name",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        SizedBox(height: 5),
                                        inputField(Icons.search, "Enter Name",
                                            searchController.nameController),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Text("location",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        inputField(
                                            Icons.location_on,
                                            " Enter destination",
                                            searchController
                                                .locationController),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                    child: optionButton(
                                        Icons.room, "Room 153", context)),
                                SizedBox(width: 10),
                                Expanded(
                                    child: dateButton(Icons.calendar_today,
                                        "Check-in", context)),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(7),
                              child: ElevatedButton(
                                onPressed: () {
                                  searchController.prinsearch();
                                  searchController.searchHotelss();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(239, 7, 86, 152),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 100),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text("Search",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Obx(() {
              if (searchController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (searchController.hotels.isEmpty) {
                return Center(child: Text("لا توجد نتائج"));
              }

              return GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.4,
                ),
                itemCount: searchController.hotels.length,
                itemBuilder: (context, index) {
                  final hotel = searchController.hotels[index];
                  final rooms = searchController.hotels[index].rooms.first;
                  return cardSearch(
                    iselect: true,
                    deletfun: () {},
                    id: hotel.id,
                    indexhotel: index,
                    hotel: hotel,
                    context: context,
                    room: rooms,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }



Widget cardSearch({
  required int indexhotel,
  required HotelsModel hotel,
  required modelRoomm room,
  required bool iselect,
  required VoidCallback? deletfun,
  required dynamic id,
  required BuildContext context,
}) {
  return InkWell(
    onTap: () {
      print("indexhotellll");
      print(indexhotel);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Detailshomescreen(
            indexhotel: indexhotel,
            hotel: hotel,
            id: hotel.id,
          ),
        ),
      );
    },
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only( left: 5,top: 10, right: 5 ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                blurStyle: BlurStyle.solid,
                spreadRadius: 2,
                blurRadius: 5,
                color: Colors.grey.withOpacity(0.2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: hotel.image.isNotEmpty
                          ? Image.network(
                              hotel.image,
                              height: 150,
                              width: 180,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.broken_image),
                            )
                          : Text("Connect the internet to load"),
                    ),
                  ),
                  // يمكنك تفعيل هذا الجزء لاحقًا لزر المفضلة
                  // Positioned(
                  //   top: 10,
                  //   left: 150,
                  //   child: GestureDetector(
                  //     onTap: () async {
                  //       // toggleFavorite();
                  //     },
                  //     child: Container(
                  //       width: 35,
                  //       height: 35,
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(80),
                  //         border: Border.all(
                  //           color: Color.fromARGB(239, 7, 86, 152),
                  //           width: 2,
                  //         ),
                  //       ),
                  //       child: Center(
                  //         child: Icon(
                  //           isFavorite ? Icons.favorite : Icons.favorite_border,
                  //           color: Color.fromARGB(239, 7, 86, 152),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 10, bottom: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            hotel.location,
                            style: TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.meeting_room, size: 16, color: Colors.grey),
                        Text(
                          'الغرف: ${room.roomsCount}',
                          style: TextStyle(color: Colors.black,fontSize: 13),
                        ),
                        Icon(Icons.people, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'العدد: ${room.defaultCapacity}',
                            style: TextStyle(color: Colors.black,fontSize: 13),
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}






  Widget inputField(
      IconData icon, String hint, TextEditingController controller,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Color.fromARGB(239, 7, 86, 152)),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color.fromARGB(239, 7, 86, 152)),
        ),
      ),
    );
  }

  Widget optionButton(IconData icon, String label, context) {
    return GetX<SearchHotelController>(
      builder: (controller) => ElevatedButton.icon(
        onPressed: () {
          bottomSheet(context: context);
        },
        icon: Icon(icon, color: Color.fromARGB(239, 7, 86, 152)),
        label: Text(
            "Rooms ${controller.countersroom.value} + ${controller.counterQuest.value} ",
            style: TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          padding: EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }



Future<void> bottomSheet({
  required BuildContext context,
}) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    isScrollControlled: true,
    builder: (ctx) => Padding(
      padding: const EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetX<SearchHotelController>(
              builder: (controller) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Room", style: TextStyle(fontSize: 16)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: controller.decrementCounter,
                              icon: Icon(Icons.remove),
                            ),
                            Text(controller.countersroom.value.toString()),
                            IconButton(
                              onPressed: controller.increament,

                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Guest", style: TextStyle(fontSize: 16)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: controller.decrementCounterQuests,
                              icon: Icon(Icons.remove),
                            ),
                            Text(controller.counterQuest.value.toString()),
                            IconButton(
                              onPressed: controller.incrementCounterQuests,
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(239, 7, 86, 152),
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  

  Widget dateButton(IconData icon, String label, BuildContext context) {
    return GetX<SearchHotelController>(
      builder: (controller) {
        String displayText = (controller.check_in_date.value.isEmpty ||
                controller.check_out_date.value.isEmpty)
            ? "filter by date"
            : "${controller.check_in_date.value} - ${controller.check_out_date.value}";

        return ElevatedButton.icon(
          onPressed: () {
            controller.prinsearch();
          },
          icon: Icon(icon, color: Color.fromARGB(239, 7, 86, 152)),
          label: Text(
            displayText,
            style: TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
    );
  }
}


//  labelText: "Range Date",
//                         border: OutlineInputBorder(),
//                         hintText: controller.check_in_date.isEmpty ||
//                                 controller.check_out_date.isEmpty
//                             ? "filter by Select Date Range "
//                             : "${controller.check_in_date.value} - ${controller.check_out_date.value}",
//                       ),
//                     )),
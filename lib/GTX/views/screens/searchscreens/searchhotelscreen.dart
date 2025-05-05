import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/categoriesController.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/controller/search_controller.dart';
import 'package:hotels/GTX/views/screens/homescreendetails/detailshomescreen.dart';
import 'package:hotels/GTX/views/widgets/ConnectionCheckWidget/ConnectionCheckWidget.dart';

class Searchhotelscreen extends StatefulWidget {
  @override
  State<Searchhotelscreen> createState() => _SearchhotelscreenState();
}

class _SearchhotelscreenState extends State<Searchhotelscreen> {
  final SearchHotelController searchController =
      Get.find<SearchHotelController>();
  final Categoriescontroller categoriesController =
      Get.find<Categoriescontroller>();

  final NetworkController connectivityController =
      Get.find<NetworkController>();
  String? selectvaluer;
  @override
  Widget build(BuildContext context) {
    
      return SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
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
                              color: Theme.of(context).colorScheme.secondary,
                              border: Border.all(
                                width: 2,
                                color: Theme.of(context).colorScheme.primary,
                              ),
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
                                            Text("Name".tr,
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            SizedBox(height: 5),
                                            inputField(Icons.search, "Enter Name".tr,
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
                                            Text("location".tr,
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            inputField(
                                                Icons.location_on,
                                                " Enter destination".tr,
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
                                            Icons.room, "Room".tr, context)),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: dateButton(Icons.calendar_today,
                                            "Check-in".tr, context)),
                                  ],
                                ),
                                Obx(() {
                                  // if (categoriesController.isLoading.value) {
                                  //   return const Center(
                                  //       child: CircularProgressIndicator());
                                  // }
        
                                  List<String> categoryNames =
                                      categoriesController.categoriesList
                                          .map((cat) => cat.name)
                                          .toList();
        
                                  return Container(
                                    margin: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 6,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0.1, 0.1),
                                            blurRadius: 0.1,
                                          )
                                        ],
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      child: DropdownButton<String>(
                                        focusColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        hint: Text("Choose Type Of Hotel".tr),
                                        alignment: Alignment.center,
                                        value:
                                            categoryNames.contains(selectvaluer)
                                                ? selectvaluer
                                                : null,
                                        items: categoriesController.categoriesList
                                            .map(
                                                (cat) => DropdownMenuItem<String>(
                                                      value: cat.name,
                                                      child: Text(cat.name),
                                                    ))
                                            .toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            selectvaluer = val;
                                            searchController.category_type.value =
                                                selectvaluer.toString();
                                            print(selectvaluer);
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                }),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.all(7),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      searchController.prinsearch();
                                      searchController.searchHotelss();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 100),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                    child: Text(
                                      "Search".tr,
                                    ),
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
                    return Center(child: Text("No Result For Serach".tr));
                  }
        
                  return ListView.builder(
                    padding: EdgeInsets.all(10),
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.1, 0.1),
            blurRadius: 0.2,
            blurStyle: BlurStyle.solid,
            spreadRadius: 0.1,
            color: Colors.grey,
          )
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: hotel.image.isNotEmpty
                      ? Image.network(
                          hotel.image,
                          width: 120,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 120,
                          height: 100,
                          color: Colors.grey,
                          child: Icon(Icons.image_not_supported),
                        ),
                ),
                SizedBox(width: 10),
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
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: Colors.grey),
                          SizedBox(width: 4),
                          Text(
                            hotel.location,
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.meeting_room,
                              size: 14, color: Colors.grey),
                          SizedBox(width: 4),
                          Text(
                            '${room.roomsCount} rooms ${room.bedsCount} bathrooms',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${room.basePrice} / night',
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detailshomescreen(
                      hotel: hotel,
                      id: hotel.id,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "View Details".tr,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                ],
              ),
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
        prefixIcon: Icon(icon, color: Color.fromARGB(239, 7, 86, 152)),
        hintText: hint,
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
                          "Continue".tr,
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
            controller.selectSearchDateRange(context);
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
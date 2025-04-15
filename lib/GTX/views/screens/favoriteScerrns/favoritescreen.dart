import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hotels/GTX/controller/Controller_favourites.dart';
import 'package:hotels/GTX/services/favourites_service.dart';
import 'package:hotels/GTX/views/widgets/favoritewidget/favorite.dart';

class Favoritescreen extends StatefulWidget {
  const Favoritescreen({super.key});

  @override
  State<Favoritescreen> createState() => _FavoritescreenState();
}

class _FavoritescreenState extends State<Favoritescreen> {
  @override
  void initState() {
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorite"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: GetX<FavouritesController>(
        init: FavouritesController(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: Icon(Icons.tune, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),

              // 🔹 عرض القائمة
              Expanded(
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.favourites.isEmpty
                        ? const Center(child: Text("لا توجد فنادق مفضلة."))
                        : GridView.builder(
                            padding: const EdgeInsets.all(10),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 15,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: controller.favourites.length,
                            itemBuilder: (context, index) {
                              var hotel = controller.favourites[index];

                              debugPrint("اسم الفندق: ${hotel.name}");
                              debugPrint("صورة الفندق: ${hotel.image}");
                              

                              return favoriteHotel(
                                hotelName: hotel.name,
                                imagehotel: hotel.image,
                                location: hotel.location,
                                deltefavorite: () => controller.deleteFavorite(hotel.id),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


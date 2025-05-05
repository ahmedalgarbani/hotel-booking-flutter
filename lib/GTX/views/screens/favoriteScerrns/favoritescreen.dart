import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/favroute_model.dart';
import 'package:hotels/GTX/controller/Booking_details_Controller.dart';
import 'package:hotels/GTX/controller/Controller_favourites.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/views/widgets/ConnectionCheckWidget/ConnectionCheckWidget.dart';
import 'package:hotels/GTX/views/widgets/favoritewidget/favorite.dart';

class Favoritescreen extends StatefulWidget {
  const Favoritescreen({super.key});

  @override
  State<Favoritescreen> createState() => _FavoritescreenState();
}

class _FavoritescreenState extends State<Favoritescreen> {
  final BookingController bookingController = Get.find<BookingController>();
  final NetworkController connectivityController =
      Get.find<NetworkController>();
  final FavouritesController favController =Get.find<FavouritesController>();
List<favrourHotelsModel> _favroutSearch = [];

  @override
  void initState() {
    super.initState();
    _favroutSearch = favController.favourites;
  }

  void _runfavroutSearchFilter(String enteredKeyword) {
    List<favrourHotelsModel> results = [];

    if (enteredKeyword.isEmpty) {
      results = favController.favourites;
    } else {
      results = favController.favourites.where((hotel) =>
        hotel.name.toLowerCase().contains(enteredKeyword.toLowerCase())
      ).toList();
    }

    setState(() {
      _favroutSearch = results;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("My Favorite".tr),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Obx(() {
        final controller = Get.find<FavouritesController>();
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
               buildSearchBar(
        context: context,
        onChanged: _runfavroutSearchFilter, // ← مرر الدالة هنا
      ),
              const SizedBox(height: 10),
              Expanded(
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.favourites.isEmpty
                        ? const Center(child: Text("لا توجد فنادق مفضلة."))
                        : GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.65,
                            ),
                            itemCount: _favroutSearch.length,
                            itemBuilder: (context, index) {
                              final hotel = _favroutSearch[index];
                              return FavoriteCard(
                                hotelName: hotel.name,
                                imagehotel: hotel.image,
                                location: hotel.location,
                                description: hotel.description,
                                deltefavorite: () =>
                                    controller.deleteFavorite(hotel.id),
                              );
                            },
                          ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

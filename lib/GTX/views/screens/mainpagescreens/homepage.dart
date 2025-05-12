import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/database.dart';
import 'package:hotels/GTX/Models/list.dart';
import 'package:hotels/GTX/Models/rigetermodel.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/NotificationsController.dart';
import 'package:hotels/GTX/controller/ThemeController.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/controller/hotelLocation_Controller.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/controller/showProfileinfo.dart';
import 'package:hotels/GTX/controller/sortedByrievew.dart';
import 'package:hotels/GTX/controller/updateprofilecontroller.dart';
import 'package:hotels/GTX/services/getAllCategories.dart';
import 'package:hotels/GTX/services/logout.dart';
import 'package:hotels/GTX/services/showprifileData.dart';
import 'package:hotels/GTX/views/screens/NotificationScreen/NotificationScreen.dart';
import 'package:hotels/GTX/views/screens/ProfileScreen/ProfileScreen.dart';
import 'package:hotels/GTX/views/screens/ReviewHotelsScreen/ReviewHotelsScreen.dart';
import 'package:hotels/GTX/views/screens/favoriteScerrns/favoritescreen.dart';
import 'package:hotels/GTX/views/screens/mybookingscreen/bookingscreen.dart';
import 'package:hotels/GTX/views/screens/nearbyhotelscreen/NearbyHotelsScreen%20.dart';
import 'package:hotels/GTX/views/screens/searchscreens/searchhotelscreen.dart';
import 'package:hotels/GTX/views/settinscreen/settingscreen.dart';
import 'package:hotels/GTX/views/showAllHotels/showAllhotels.dart';
import 'package:hotels/GTX/views/widgets/ConnectionCheckWidget/ConnectionCheckWidget.dart';
import 'package:hotels/GTX/views/widgets/homepage/carddhotel.dart';
import 'package:hotels/GTX/views/widgets/homepage/citysearch.dart';
import 'package:hotels/GTX/views/widgets/homepage/languagebottunsheet.dart';
import 'package:hotels/GTX/views/widgets/homepage/nearbyhotel.dart';
import 'package:hotels/GTX/views/widgets/homepage/rievewHotel.dart';
import 'package:hotels/GTX/views/widgets/homepage/searchotel.dart';
import 'package:hotels/GTX/views/widgets/registers/AuthSelectionScreen.dart';

class Homepage extends StatefulWidget {
  Homepage({
    super.key,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // late Future<List<HotelsModel>> hotelsList;
  GlobalKey<ScaffoldState> Scaffoldkey = GlobalKey<ScaffoldState>();
  final ListControle _listControle = ListControle();
  // final Hotelinf _hotelinf = Hotelinf();
  bool isLoading = true;
  SqlDb sqlDb = SqlDb();

  int _currentIndex = 0;

  final Hotelinfo controllerhotel = Get.find<Hotelinfo>();
  final HotelsController controller = Get.find<HotelsController>();
  final Showprofileinfo profilelist = Get.find<Showprofileinfo>();
  final Updateprofilecontroller fetchprofile =
      Get.find<Updateprofilecontroller>();
  late final Rigetermodel profile;

  final Showprofileinfo showprofileinfo = Get.find<Showprofileinfo>();
  // final bool isLoggedIn  = Get.find<SignupController>().isLoading.value;
  final HotelsController locationController = Get.find<HotelsController>();
  @override
  void initState() {
    super.initState();
    // Getallcategories().getetcategories();
    // Showprifiledata().getAlluser();
    // Showprofileinfo().fetchAllUser();
    Get.find<Hotelinfo>().fetchHotels();
    Get.find<HotelsController>().fetchHotelsByLocation();
    Get.find<SortedHotelReviewController>().fetchHotelsorteds();
  }

  @override
  // Future<void> favorite(int id) async {
  //   bool success = await FavouritesService().addToFavourites(id);
  //   if (success) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("تمت إضافة الفندق إلى المفضلة ")),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("حدث خطأ أثناء إضافة الفندق للمفضلة")),
  //     );
  //   }
  // }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColorico = isDark ? Colors.grey.shade700 : Colors.white;
    final iconColoricon =
        isDark ? Colors.white : Color.fromARGB(255, 39, 63, 70);
    final iconColorappar = isDark ? Colors.grey.shade700 : Colors.white;
    final isDarkcontainer = Theme.of(context).brightness == Brightness.dark;
    final iconColorcontainer = isDarkcontainer
        ? Colors.grey.shade800
        : Color.fromARGB(255, 39, 63, 70);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        key: Scaffoldkey,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  color: iconColorappar,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/icon-192.png'),
                        radius: 20,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Booking hotel".tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Searchhotelscreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        //  init:Showprofileinfo();
                        // searchhotel(context, Scaffoldkey),

                        // titleCard(),height: _hotelinf.isLoading.value || _hotelinf.categories.isEmpty ? 20 : 250,
                        titleCard(
                          context: context,
                          titleText: "Popular Hotel :",
                          seeAllText: "See All :",
                          navigateToPage: Showallhotels(),
                        ),

                        GetX<Hotelinfo>(
                          builder: (controller) {
                            if (controller.hotelsList.isNotEmpty) {
                              return SizedBox(
                                height: 250,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      min(controller.hotelsList.length, 4),
                                  itemBuilder: (context, index) {
                                    final hotel = controller.hotelsList[index];
                                    return cardHotel(
                                      hotel: hotel,
                                      context: context,
                                      indexhotel: index,
                                      favorite: () => controller.favorite(
                                          hotel.id, context),
                                      toggleFavorite: () =>
                                          controller.toggleFavorite(),
                                      isFavorite: controller.isFavorite.value,
                                    );
                                  },
                                ),
                              );
                            } else {
                              return controller.isFetching.value
                                  ? Center(child: CircularProgressIndicator())
                                  : Center(
                                      child: imageNoConnection(
                                      width: double.infinity,
                                      height: 200,
                                      imagepath: "assets/imagehome.png",
                                    ));
                            }
                          },
                        ),

                        Obx(() {
                          if (locationController.hotelsList.isNotEmpty) {
                            return titleCard(
                              context: context,
                              titleText: "الفنادق القريبه في مدينتك".tr,
                              seeAllText: "See All :",
                              navigateToPage:
                                  locationController.hotelsList.isNotEmpty
                                      ? NearbyHotelsScreen()
                                      : ReviewHotelsScreen(),
                            );
                          } else {
                            return titleCard(
                              context: context,
                              titleText: "الفنادق الاعلئ تقييما :",
                              seeAllText: "See All :",
                              navigateToPage:
                                  locationController.hotelsList.isNotEmpty
                                      ? NearbyHotelsScreen()
                                      : ReviewHotelsScreen(),
                            );
                          }
                        }),

                        SizedBox(
                          height: 300,
                          child: Obx(() {
                            // final HotelsController locationController =
                            //     Get.find<HotelsController>();
                            final SortedHotelReviewController ratingController =
                                Get.find<SortedHotelReviewController>();

                            if (locationController.isLoading.value) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (locationController.hotelsList.isEmpty ||
                                locationController.errorMessage.isNotEmpty) {
                              if (ratingController.hotelsListSorted.isEmpty) {
                                return const Center(
                                    child: Text("لا توجد فنادق متاحة حاليًا."));
                              }

                              return ListView.builder(
                                itemCount:
                                    ratingController.hotelsListSorted.length,
                                itemBuilder: (context, index) {
                                  final hotel =
                                      ratingController.hotelsListSorted[index];
                                  if (hotel.reviews.isEmpty)
                                    return const SizedBox();

                                  final review = hotel.reviews.first;
                                  final averageRating =
                                      (review.ratingCleanliness +
                                              review.ratingLocation +
                                              review.ratingService +
                                              review.ratingValueForMoney) /
                                          4;

                                  return rievewHotel(
                                    hotel: hotel,
                                    context: context,
                                    image: hotel.image,
                                    name:
                                        "${hotel.name} (${averageRating.toStringAsFixed(1)})",
                                    rievewHotel: averageRating,
                                    id: hotel.id,
                                    hotelLocation: hotel.location,
                                  );
                                },
                              );
                            }

                            return ListView.builder(
                              itemCount: locationController.hotelsList.length,
                              itemBuilder: (context, index) {
                                final hotel =
                                    locationController.hotelsList[index];
                                return hotelCard(
                                  image: hotel.image,
                                  name: hotel.name,
                                  hotelLocation: hotel.location,
                                  context: context,
                                  id: hotel.id,
                                  hotel: hotel,
                                );
                              },
                            );
                          }),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Favoritescreen(),
            Bookingscreen(),
            // AuthSelectionScreen(),
            Obx(() {
              final hasUser = showprofileinfo.profileuserlist.isNotEmpty;
              return hasUser ? Settingscreen() : AuthSelectionScreen();
            }),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: iconColorico,
          color: iconColorcontainer,
          buttonBackgroundColor: iconColorcontainer,
          height: 60,
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
              size: 30,
            ),
            Icon(
              Icons.favorite,
              color: Colors.white,
              size: 30,
            ),
            Icon(
              Icons.hotel,
              color: Colors.white,
              size: 30,
            ),
            Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

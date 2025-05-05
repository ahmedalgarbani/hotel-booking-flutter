import 'dart:ffi';
import 'dart:math';
import 'dart:typed_data';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/database.dart';
import 'package:hotels/GTX/Models/list.dart';
import 'package:hotels/GTX/Models/rigetermodel.dart';
import 'package:hotels/GTX/controller/NotificationsController.dart';
import 'package:hotels/GTX/controller/ThemeController.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/controller/hotelLocation_Controller.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/controller/showProfileinfo.dart';
import 'package:hotels/GTX/controller/updateprofilecontroller.dart';
import 'package:hotels/GTX/services/getAllCategories.dart';
import 'package:hotels/GTX/services/logout.dart';
import 'package:hotels/GTX/services/showprifileData.dart';
import 'package:hotels/GTX/views/screens/NotificationScreen/NotificationScreen.dart';
import 'package:hotels/GTX/views/screens/ProfileScreen/ProfileScreen.dart';
import 'package:hotels/GTX/views/screens/favoriteScerrns/favoritescreen.dart';
import 'package:hotels/GTX/views/screens/mybookingscreen/bookingscreen.dart';
import 'package:hotels/GTX/views/screens/nearbyhotelscreen/NearbyHotelsScreen%20.dart';
import 'package:hotels/GTX/views/screens/searchscreens/searchhotelscreen.dart';
import 'package:hotels/GTX/views/showAllHotels/showAllhotels.dart';
import 'package:hotels/GTX/views/widgets/ConnectionCheckWidget/ConnectionCheckWidget.dart';
import 'package:hotels/GTX/views/widgets/homepage/carddhotel.dart';
import 'package:hotels/GTX/views/widgets/homepage/citysearch.dart';
import 'package:hotels/GTX/views/widgets/homepage/languagebottunsheet.dart';
import 'package:hotels/GTX/views/widgets/homepage/nearbyhotel.dart';
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
  final HotelsController controller = Get.find<HotelsController>();
  final Showprofileinfo profilelist = Get.find<Showprofileinfo>();
  final Updateprofilecontroller fetchprofile =
      Get.find<Updateprofilecontroller>();
  late final Rigetermodel profile;
  final NetworkController connectivityController =
      Get.find<NetworkController>();
  final NotificationsController notificationsController =
      Get.find<NotificationsController>();
  final Showprofileinfo showprofileinfo = Get.find<Showprofileinfo>();

  @override
  void initState() {
    super.initState();
    Getallcategories().getetcategories();
    Showprifiledata().getAlluser();
    Showprofileinfo().fetchAllUser();
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

  Widget build(BuildContext context) {
    
      
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        key: Scaffoldkey,
        drawer: Drawer(
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                Stack(
                  children: [
                    Obx(() {
                      final hasUser =
                          showprofileinfo.profileuserlist.isNotEmpty;
                      final user = hasUser
                          ? showprofileinfo.profileuserlist.first
                          : null;

                      return UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child: ClipOval(
                            child: hasUser
                                ? Image.network(
                                    user!.image ?? '',
                                    fit: BoxFit.cover,
                                    width: 90,
                                    height: 90,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      "assets/Screenshot.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.asset(
                                    "assets/Screenshot.jpg",
                                    fit: BoxFit.cover,
                                    width: 90,
                                    height: 90,
                                  ),
                          ),
                        ),
                        accountName: Text(
                          hasUser
                              ? "${user!.firstName} ${user.lastName}"
                              : "No User".tr,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        accountEmail: Text(
                          hasUser ? user!.email : "No Email".tr,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 15,
                          ),
                        ),
                      );
                    }),
                    Positioned(
                      top: 15,
                      right: Get.locale?.languageCode == 'ar' ? null : 10,
                      left: Get.locale?.languageCode == 'ar' ? 10 : null,
                      child: IconButton(
                        icon: Icon(
                          Get.isDarkMode
                              ? Icons.wb_sunny
                              : Icons.nightlight_round,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                        onPressed: () {
                          Get.find<ThemeController>().toggleTheme();
                        },
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Text(
                    "Logout".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: const Color.fromARGB(220, 7, 86, 152),
                    size: 30,
                  ),
                  onTap: () {
                    AuthService().logOut(context);
                  },
                ),
                ListTile(
                  title: Text(
                    "Language".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.language,
                    color: Color.fromARGB(220, 7, 86, 152),
                    size: 30,
                  ),
                  onTap: () {
                    languagebuttnsheet(context: context);
                  },
                ),
                ListTile(
                  title: Text(
                    "Notifications".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.notification_add,
                    color: Color.fromARGB(220, 7, 86, 152),
                    size: 30,
                  ),
                  onTap: () {
                    Get.to(() => NotificationScreen());
                  },
                ),
                ListTile(
                  title: Text(
                    "My personal File".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Icons.person,
                    color: Color.fromARGB(220, 7, 86, 152),
                    size: 30,
                  ),
                  onTap: () {
                    Get.to(() => ProfileScreen());

                    print("object");
                    for (var user in profilelist.profileuserlist) {
                      print("Username: ${user.username}");
                      print("Email: ${user.email}");
                      print("First Name: ${user.firstName}");
                      print("Last Name: ${user.lastName}");
                      print("Phone: ${user.phone}");
                      print("Password: ${user.password}");
                      print("Image: ${user.image}");
                      print("birth_date: ${user.birth_date}");
                      print("gender: ${user.gender}");
                      print("-----------");
                    }
                  },
                ),
              ],
            )),
        body: SafeArea(
          child: IndexedStack(
            index: _currentIndex,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    //  init:Showprofileinfo();
                    searchhotel(context, Scaffoldkey),

                    titleCity(),
                    SizedBox(
                      height: 65,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _listControle.cityData.length,
                        itemBuilder: (context, index) {
                          return citySearch(
                            _listControle.cityData[index]["image"]!,
                            _listControle.cityData[index]["name"]!,
                            _listControle.cityData[index]["date"]!,
                            context,
                          );
                        },
                      ),
                    ),
                    // titleCard(),height: _hotelinf.isLoading.value || _hotelinf.categories.isEmpty ? 20 : 250,
                    titleCard(
                      context: context,
                      titleText: "Popular Hotel :",
                      seeAllText: "See All :",
                      navigateToPage: Showallhotels(),
                    ),
                   
                    SizedBox(
                      height: 300,
                      child: GetX<Hotelinfo>(
                        init: Hotelinfo(),
                        builder: (controller) {
                          if (controller.hotelsList.isNotEmpty) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: min(controller.hotelsList.length, 4),
                              itemBuilder: (context, index) {
                                print(
                                    "Finished fetching data. Total hotels: ${controller.hotelsList[index].name}");
                                return cardHotel(
                                  hotel: controller.hotelsList[index],
                                  context: context,
                                  indexhotel: index,
                                  favorite: () => controller.favorite(
                                      controller.hotelsList[index].id, context),
                                  toggleFavorite: () =>
                                      controller.toggleFavorite(),
                                  isFavorite: controller.isFavorite.value,
                                );
                              },
                            );
                          } else {
                            return controller.isFetching.value
                                ? Center(child: CircularProgressIndicator())
                                : Center(
                                    child: Text(
                                        'No hotels available, please check your connection.'));
                          }
                        },
                      ),
                    ),

                    titleCard(
                      context: context,
                      titleText: "Near By Hotel :",
                      seeAllText: "See All :",
                      navigateToPage: NearbyHotelsScreen(),
                    ),
                    SizedBox(
                      height: 300,
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (controller.errorMessage.isNotEmpty) {
                          return Center(
                            child: Text(
                              controller.errorMessage.value,
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (controller.hotelsList.isEmpty) {
                          return const Center(
                              child: Text('لا توجد فنادق في منطقتك'));
                        }
                        return ListView.builder(
                          itemCount: controller.hotelsList.length,
                          itemBuilder: (context, index) {
                            final hotel = controller.hotelsList[index];
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
              Favoritescreen(),
              Bookingscreen(),
              AuthSelectionScreen(),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          color: Theme.of(context).colorScheme.primary,
          buttonBackgroundColor: Theme.of(context).colorScheme.primary,
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
      );
  
  }
}

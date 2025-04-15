import 'dart:ffi';
import 'dart:typed_data';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/database.dart';
import 'package:hotels/GTX/Models/list.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/hotelLocation_Controller.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/controller/hotels_controller.dart';
import 'package:hotels/GTX/services/favourites_service.dart';
import 'package:hotels/GTX/services/logout.dart';
import 'package:hotels/GTX/services/show_hotel_services.dart';
import 'package:hotels/GTX/views/screens/favoriteScerrns/favoritescreen.dart';
import 'package:hotels/GTX/views/screens/mybookingscreen/bookingscreen.dart';
import 'package:hotels/GTX/views/screens/searchscreens/searchhotelscreen.dart';
import 'package:hotels/GTX/views/widgets/homepage/carddhotel.dart';
import 'package:hotels/GTX/views/widgets/homepage/citysearch.dart';
import 'package:hotels/GTX/views/widgets/homepage/nearbyhotel.dart';
import 'package:hotels/GTX/views/widgets/homepage/searchotel.dart';
import 'package:hotels/GTX/views/widgets/registers/mainregisre.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> favorite(int id) async {
    bool success = await FavouritesService().addToFavourites(id);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("تمت إضافة الفندق إلى المفضلة ✅")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ أثناء إضافة الفندق للمفضلة")),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: Scaffoldkey,
      drawer: Drawer(
          child: Column(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(
                  220,
                  7,
                  86,
                  152,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                child: Container(
                  margin: EdgeInsets.all(5),
                  height: 180,
                  width: 180,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/Screenshot.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                backgroundColor: Color.fromARGB(
                  220,
                  7,
                  86,
                  152,
                ),
              ),
              accountName: Text("Mosa",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              accountEmail: Text("mosa@gmail.com",
                  style: TextStyle(color: Colors.grey[400], fontSize: 15))),
          ListTile(
            title: Text("logout"),
            leading: Icon(
              Icons.logout,
              color: const Color.fromARGB(
                220,
                7,
                86,
                152,
              ),
            ),
            onTap: () {
              AuthService().logOut(context);
            },
          ),
          ListTile(
            title: Text("Notfication"),
            leading: Icon(
              Icons.notification_add,
              color: Color.fromARGB(
                220,
                7,
                86,
                152,
              ),
            ),
            onTap: () {
              // GetAllHotelsSearch().getAllHotels(
              //     nameHotelSearch: "فندق حي الاصبحي",
              //     kocationHotelSearch: "",
              //     adult_number: 1);
            },
          )
        ],
      )),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                searchhotel(context, Scaffoldkey),
                const SizedBox(height: 7),
                titleCity(),
                const SizedBox(height: 7),
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
                const SizedBox(height: 3),
                // titleCard(),height: _hotelinf.isLoading.value || _hotelinf.categories.isEmpty ? 20 : 250,
                const SizedBox(height: 30),
                SizedBox(
                  height: 300,
                  child: GetX<Hotelinfo>(
                    init: Hotelinfo(),
                    builder: (controller) {
                      if (controller.hotelsList.isNotEmpty) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.hotelsList.length,
                          itemBuilder: (context, index) {
                            print(
                                "Finished fetching data. Total hotels: ${controller.hotelsList[index].name}");
                            return cardHotel(
                              hotel: controller.hotelsList[index],
                              context: context,
                              indexhotel: index,
                              favorite: () => controller.favorite(
                                  controller.hotelsList[index].id, context),
                              toggleFavorite: () => controller.toggleFavorite(),
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

                titleNearby(),
                SizedBox(
                  height: 300,
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
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
                          date: hotel.location,
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
          LoginScreen(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Color.fromARGB(239, 7, 86, 152),
        buttonBackgroundColor: Color.fromARGB(239, 7, 86, 152),
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

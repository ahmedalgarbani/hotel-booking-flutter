import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/controller/hotelLocation_Controller.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/controller/hotels_controller.dart';
import 'package:hotels/GTX/views/widgets/ConnectionCheckWidget/ConnectionCheckWidget.dart';
import 'package:hotels/GTX/views/widgets/homepage/carddhotel.dart';
import 'package:hotels/GTX/views/widgets/showAllhotelwig/showallhotelwidget.dart';

class Showallhotels extends StatefulWidget {
  @override
  State<Showallhotels> createState() => _ShowallhotelsState();
}

class _ShowallhotelsState extends State<Showallhotels> {
  final Hotelinfo controller = Get.find<Hotelinfo>();
  final NetworkController connectivityController =
      Get.find<NetworkController>();
      @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchHotels();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("Hotels".tr),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.hotelsList.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: GridView.builder(
              itemCount: controller.hotelsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.80,
              ),
              itemBuilder: (context, index) {
                final hotel = controller.hotelsList[index];
                return Showallhotelwidget(
                  hotel: controller.hotelsList[index],
                  context: context,
                  indexhotel: index,
                  favorite: () => controller.favorite(
                      controller.hotelsList[index].id, context),
                  toggleFavorite: () => controller.toggleFavorite(),
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
                  height: double.infinity,
                  imagepath: "assets/imageall.png",
                ));
        }
      }),
    );
  }
}

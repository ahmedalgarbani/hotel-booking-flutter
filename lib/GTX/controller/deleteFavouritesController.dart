import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/Controller_favourites.dart';
import 'package:hotels/GTX/services/favourites_service.dart';
import 'package:http/http.dart';

class Deletefavouritescontroller extends GetxController {
  var isLoading = false.obs;
  var isFavorite = false.obs;
  final FavouritesController favouritesController =
      Get.find<FavouritesController>();
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> deleteFavorite(int id) async {

    try {
      print("delete ID: $id");

      if (id == 0 || id == null) {
        print("The id is wrong or null");
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text("The id is wrong or null")),
        );
        return;
      }

      bool success = await FavouritesService().removeFromFavourites(id);

      if (success) {
        favouritesController.favourites.removeWhere((hotel) => hotel.id == id);
        favouritesController.favourites.refresh();
        print(" Successful");
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text("Hotel removed successfully")),
        );
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
              content: Text("This hotel is not in the favourites list")),
        );
      }
    } catch (e) {
      print("Error when deleting: $e");
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
            content: Text("Error during deletion, please try again later")),
      );
    }
  }
}

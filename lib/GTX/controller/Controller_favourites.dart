import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/favroute_model.dart';
import 'package:hotels/GTX/controller/flashbar.dart';
import 'package:hotels/GTX/services/favourites_service.dart';

class FavouritesController extends GetxController {
  var favourites = <favrourHotelsModel>[].obs;
  var isLoading = false.obs;
  var isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavourites();
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void fetchFavourites() async {
    try {
      isLoading.value = true;
      List<favrourHotelsModel> favHotels =
          await FavouritesService().getFavourites();

      for (var hotel in favHotels) {
        print(" hotel: ${hotel.name}, photo: ${hotel.image}");
      }

      favourites.assignAll(favHotels);
    } catch (e) {
      print("wrong when add the favroute $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteFavorite(int id) async {
    try {
      print("delete ID: $id");

      if (id == 0 || id == null) {
        print("the id is wrong");
        return;
      }
      bool? success = await FavouritesService().removeFromFavourites(id);
       fetchFavourites();

      if (success == true) {
        favourites.removeWhere((hotel) => hotel.id == id);
        favourites.refresh();
       
        print("Successful");
        print("Sccessful");
        Get.snackbar("successful", "successful Delete Hotel From Favroute!",
            backgroundColor: Colors.green);
            fetchFavourites();
      } else {
        print("wrong to delete of no hotel");
        print("Sccessful");
        Get.snackbar("successful", "successful Delete Hotel From Favroute!",
            backgroundColor: Colors.green);
      }
    } catch (e) {
      print("wrong when delete $e");
      ScaffoldMessenger.of(Get.context!).showSnackBar(
         SnackBar(
            content: Text("wrong when delete communcate with engreening")),
      );
    }
  }
}

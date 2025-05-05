import 'package:get/get.dart';
import 'package:hotels/GTX/Models/BookingModel.dart';
import 'package:hotels/GTX/Models/categories_Model.dart';
import 'package:hotels/GTX/services/BookingService.dart';
import 'package:hotels/GTX/services/getAllCategories.dart';
import 'package:hotels/GTX/services/getBookinService.dart';


class Categoriescontroller extends GetxController {
  var categoriesList = <CategoriesModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchcategoriesList();
  }

  void fetchcategoriesList() async {
    try {
      isLoading.value = true;
      List<CategoriesModel> data = await Getallcategories().getetcategories();
      categoriesList.assignAll(data);
    } catch (e) {
      print(" Error fetching Categories : $e");
    } finally {
      isLoading.value = false;
    }
  }
}
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/Models/categories_Model.dart';
import 'package:hotels/GTX/helper/api.dart';


class Getallcategories {
  Future<List<CategoriesModel>> getetcategories() async {
    final String url = 'http://192.168.8.115:8000/api/categories/';
  List<CategoriesModel> data = await Api().getAllCategoreies(url:url);
    return data;
  }
}
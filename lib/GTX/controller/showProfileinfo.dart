import 'package:get/get.dart';
import 'package:hotels/GTX/Models/rigetermodel.dart';
import 'package:hotels/GTX/services/showprifileData.dart';

class Showprofileinfo extends GetxController {
  var profileuserlist = <Rigetermodel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllUser(); 
  }

  void fetchAllUser() async {
    try {
      isLoading.value = true;
      List<Rigetermodel> data = await Showprifiledata().getAlluser();
      profileuserlist.assignAll(data);
      print(" Fetched users: ${profileuserlist.length}");
    } catch (e) {
      print(" Error fetching profile: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:get/get.dart';

class CounterController extends GetxController {
  RxInt counters = 0.obs;
  RxInt counter = 0.obs;
  RxInt counterQuest = 0.obs;
  void increament() {
    counters.value++;
    // update();
  }

  // void incrementCounter() {
  //   counters.value--;
  // }

  void decrementCounter() {
    if (counters > 0) counters--;
  }

  void incrementCounterQuests() {
    counterQuest++;
  }

  void decrementCounterQuests() {
    if (counterQuest > 0) counterQuest--;
  }
}

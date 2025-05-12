import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/rievewRRoomDetail_controller.dart';

Widget reviewRoom({required int hootelid, required int roomid}) {
final RievewrroomdetailController controller = Get.find<RievewrroomdetailController>();

  return Container(
    padding: EdgeInsets.all(8),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Your Review".tr,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                bool isSelected = controller.rating.value == index + 1;
                return GestureDetector(
                  onTap: () {
                    controller.rating.value = index + 1;
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.amber.withOpacity(0.3)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color.fromARGB(255, 39, 63, 70),
                      ),
                    ),
                    child: Row(
                      children: List.generate(
                        index + 1,
                        (_) =>
                            Icon(Icons.star, color: Colors.amber, size: 20),
                      ),
                    ),
                  ),
                );
              }),
            )),
        Row(
          children: [
            
            SizedBox(width: 8),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      controller.submitReview(
                        hotelId: hootelid,
                        roomTypeId: roomid,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16)),
                    child: Text("Send Review".tr),
                  )),


                  Expanded(
              child: Container(
                margin: EdgeInsets.all(5),
                child: TextField(
                  controller: controller.reviewTextController,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.reviews,
                        color: Color.fromARGB(255, 39, 63, 70)),
                    hintText: "Enter Your Review".tr,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/HotelReviewController.dart';

Widget buildRating({required int id}) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            showModalBottomSheet(
              context: Get.context!,
              isScrollControlled: true,
              builder: (context) =>
                  buildRatingBottomSheet(id: id, context: context),
            );
          },
          child: Text("إضافة تقييم"),
        ),
      ],
    ),
  );
}

Widget buildRatingBottomSheet(
    {required int id, required BuildContext context}) {
  final controller = Get.find<HotelReviewController>();
  final reviewTextController = TextEditingController();

  return Padding(
    padding: EdgeInsets.only(
      left: 16,
      right: 16,
      top: 16,
      bottom: MediaQuery.of(context).viewInsets.bottom + 16,
    ),
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("إضافة تقييم",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildRatingButton("الخدمة"),
              buildRatingButton("النظافة"),
              buildRatingButton("الموقع"),
              buildRatingButton("السعر"),
            ],
          ),
          SizedBox(height: 20),
          TextField(
            controller: reviewTextController,
            decoration: InputDecoration(
              labelText: "اكتب مراجعتك هنا",
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          SizedBox(height: 20),
          Obx(() => controller.isSubmitting.value
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    await controller.submitHotelReview(
                      hotel: id,
                      review: reviewTextController.text,
                    );
                    Get.back();
                    if (controller.reviewStatus.value.contains("Exception: User not authenticated")) {
                      Get.snackbar("شكراً", "please loginin your are not login");
                      print(controller.reviewStatus.value);
                    }
                  },
                  child: Text("إرسال التقييم"),
                )),
        ],
      ),
    ),
  );
}

Widget buildRatingButton(String name) {
  final controller = Get.find<HotelReviewController>();

  return ElevatedButton(
    onPressed: () {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("تقييم $name"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("اختر تقييمًا من 1 إلى 5"),
                SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: List.generate(5, (index) {
                    final rating = index + 1;
                    return OutlinedButton(
                      onPressed: () {
                        controller.setRating(name, rating);
                        Navigator.of(context).pop();
                      },
                      child: Text('$rating'),
                    );
                  }),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("إلغاء"),
              ),
            ],
          );
        },
      );
    },
    child: Text(name),
  );
}

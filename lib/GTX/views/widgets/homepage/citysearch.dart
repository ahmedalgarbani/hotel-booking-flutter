import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget citySearch(
    String image, String name, String date, BuildContext context) {
  // TextEditingController searchController = TextEditingController(text: name);
  return InkWell(
    onTap: () {
      // showSearch(
      //     context: context, delegate: Hotelscreensearch(nameCity: searchController));
    },
    child: Container(
      width: 220,
      margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 2,
              spreadRadius: 1,
              color: Colors.grey,
              blurStyle: BlurStyle.solid,
            )
          ]),
      child: Row(
        children: [
          Column(
            children: [
              Padding(padding: EdgeInsets.only(left: 1)),
              Container(
                margin: EdgeInsets.only(left: 5, top: 2, bottom: 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: 18,
          ),
          Column(
            children: [Text(name), Text(date)],
          ),
        ],
      ),
    ),
  );
}

Widget titleCity() {
  bool isArabic = Get.locale?.languageCode == 'ar';

  return Container(
    margin: const EdgeInsets.only(left: 10, top: 5, right: 10),
    alignment: isArabic ? Alignment.bottomRight : Alignment.bottomLeft,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          'continue_search'.tr,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

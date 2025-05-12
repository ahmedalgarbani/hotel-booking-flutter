import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/rigetermodel.dart';
import 'package:hotels/GTX/controller/showProfileinfo.dart';
import 'package:hotels/GTX/views/screens/searchscreens/searchhotelscreen.dart';

Widget searchhotel(
  BuildContext context,
  GlobalKey<ScaffoldState> key,
) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 30),
    decoration: BoxDecoration(
      
      color: Theme.of(context).colorScheme.secondary,
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withAlpha((0.1 * 255).toInt()),
          blurRadius: 5,
          spreadRadius: 5,
           blurStyle: BlurStyle.solid,
          offset: Offset(0.4, 0.4)

        )
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [const SizedBox(width: 10), accountInfo()],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Searchhotelscreen(),
                ),
              );
            },
            icon: const Icon(Icons.search,
                color: Color.fromARGB(
                  220,
                  7,
                  86,
                  152,
                )),
          ),
        ),
      ],
    ),
  );
}

Widget accountInfo() {
  return GetX<Showprofileinfo>(builder: (controller) {
    if (controller.profileuserlist.isEmpty) {
      return Text("No User".tr, style: TextStyle(color: Colors.grey));
    }

    final profiles = controller.profileuserlist[0];

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " :Hello  ".tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                profiles.firstName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text("Welcom Back"),
        ],
      ),
    );
  });
}

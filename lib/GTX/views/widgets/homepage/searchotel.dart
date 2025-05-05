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
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withAlpha((0.1 * 255).toInt()),
          blurRadius: 5,
          spreadRadius: 1,
        )
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [
              IconButton(
                onPressed: () => key.currentState?.openDrawer(),
                icon: const Icon(Icons.menu,
                    color: Color.fromARGB(
                      220,
                      7,
                      86,
                      152,
                    )),
              ),
              const SizedBox(width: 10),
              accountInfo()
            ],
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
      return Text("No User", style: TextStyle(color: Colors.grey));
    }

    final profiles = controller.profileuserlist[0];

    return Row(
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
    );
  });
}


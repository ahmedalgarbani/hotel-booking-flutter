import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';

class ConnectionCheckWidget extends StatelessWidget {
  const ConnectionCheckWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final NetworkController connectivityController = Get.find<NetworkController>();

    return   Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/networkiame.png',
                  width: 200,
                ),
                SizedBox(height: 20),
                Text(
                  "لا يوجد اتصال بالإنترنت",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
  }
}



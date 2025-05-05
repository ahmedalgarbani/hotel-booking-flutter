import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/views/widgets/ConnectionCheckWidget/ConnectionCheckWidget.dart';
import 'package:hotels/GTX/views/widgets/registers/mainregisre.dart';

class Mainregisre extends StatefulWidget {
  @override
  State<Mainregisre> createState() => _MainregisreState();
}

class _MainregisreState extends State<Mainregisre> {
   final NetworkController connectivityController =
      Get.find<NetworkController>();
  @override
  Widget build(BuildContext context) {
   
      return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
      child: Column(
        children: [LoginScreen()],
      ),
    ));
    
   
  }
}

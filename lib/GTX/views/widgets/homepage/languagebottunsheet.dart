import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future languagebuttnsheet({required BuildContext context}) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(child: Text("Choose Language".tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
            ListTile(
              title: Text(
                "Arabic".tr,  
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                 
                ),
              ),
              leading: Icon(
                Icons.language,
                color: Colors.green,
                size: 28,
              ),
              onTap: () {
                Get.updateLocale(const Locale('ar', 'SA'));
                Navigator.pop(context); 
              },
            ),
            ListTile(
              title: Text(
                "English".tr, 
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                 
                ),
              ),
              leading: Icon(
                Icons.language,
                color: Colors.blue,
                size: 28,
              ),
              onTap: () {
                Get.updateLocale(const Locale('en', 'US'));
                Navigator.pop(context); 
              },
            ),
          ],
        ),
      );
    },
  );
}

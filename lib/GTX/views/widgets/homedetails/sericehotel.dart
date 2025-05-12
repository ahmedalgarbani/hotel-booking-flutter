import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget serviceHotel({required String nameServiceHotel}) {
  
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.blue),
    ),
    child: Text(
      nameServiceHotel,
      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
    ),
  );
}

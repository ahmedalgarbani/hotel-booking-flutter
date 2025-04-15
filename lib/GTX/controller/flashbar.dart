import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showFlushbarMessage(BuildContext context, String title, String message, Color color) {
  Flushbar(
    title: title,  
    message: message,
    duration: Duration(seconds: 5),
    backgroundColor: color,
    flushbarPosition: FlushbarPosition.TOP,
    messageText: Center( 
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16, 
          fontWeight: FontWeight.bold, 
          color: Colors.white, 
        ),
      ),
    ),
  )..show(context);
}

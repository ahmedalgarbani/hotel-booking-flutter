import 'package:flutter/material.dart';
import 'package:hotels/GTX/views/widgets/registers/mainregisre.dart';

class Mainregisre extends StatefulWidget {
  @override
  State<Mainregisre> createState() => _MainregisreState();
}

class _MainregisreState extends State<Mainregisre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [LoginScreen()],
      ),
    ));
  }
}

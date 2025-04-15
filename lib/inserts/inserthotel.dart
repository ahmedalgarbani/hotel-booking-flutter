import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/inserts/button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hotels/GTX/Models/database.dart';

class AddcatogaryWidget extends StatefulWidget {
  const AddcatogaryWidget({super.key});

  @override
  State<AddcatogaryWidget> createState() => _AddCatogriesWidgState();
}

class _AddCatogriesWidgState extends State<AddcatogaryWidget> {
  SqlDb sqlDb = SqlDb();

  TextEditingController hotelName = TextEditingController();
  TextEditingController hotelEmail = TextEditingController();
  TextEditingController hotelDescription = TextEditingController();
  final Hotelinf _hotelinf = Hotelinf();

  Uint8List? hotelImage;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() async {
        hotelImage = await image.readAsBytes();
      });
    }
  }

  Future<void> addCategory() async {
    if (hotelImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى اختيار صورة')),
      );
      return;
    }

    int response = await sqlDb.insertDataimag(
      '''
      INSERT INTO hotels (hotel_name, hotel_email, hotel_description, hotel_image)
      VALUES (?, ?, ?, ?)
      ''',
      [hotelName.text, hotelEmail.text, hotelDescription.text, hotelImage],
    );

    if (response > 0) {

    _hotelinf.readAllData();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => MyWidget(   
                  )),
          (route) => route.isFirst,
          
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Info Hotel"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: 600,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            _buildTextField(hotelName, 'اسم الفندق'),
                            SizedBox(height: 10),
                            _buildTextField(
                                hotelEmail, 'البريد الإلكتروني للفندق'),
                            SizedBox(height: 10),
                            _buildTextField(hotelDescription, 'وصف الفندق'),
                            SizedBox(height: 10),
                            hotelImage != null
                                ? Image.memory(hotelImage!, height: 150)
                                : Text('لم يتم اختيار صورة'),
                            SizedBox(height: 10),
                            _buildButton('اختيار صورة', Icons.image, pickImage),
                            SizedBox(height: 10),
                            _buildButton('إضافة', Icons.add, addCategory),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      width: double.infinity,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.green),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.green, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 18, 47, 71),
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.green, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              text,
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

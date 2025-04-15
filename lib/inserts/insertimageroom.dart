import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hotels/inserts/button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hotels/GTX/Models/database.dart';

class InsertImageRoom extends StatefulWidget {
  final int? id;
  final String categoryName;

  const InsertImageRoom({Key? key, this.id, required this.categoryName})
      : super(key: key);

  @override
  State<InsertImageRoom> createState() => _InsertImageRoomState();
}

class _InsertImageRoomState extends State<InsertImageRoom> {
  SqlDb sqlDb = SqlDb();
  final ImagePicker _picker = ImagePicker();
  List<File> pickedImages = []; // قائمة لتخزين الصور المختارة
  List<Map> hotelList = [];
  List<Map> roomTypeList = [];
  int? selectedHotelId;
  int? selectedRoomTypeId;

  @override
  void initState() {
    super.initState();
    fetchHotels();
    fetchRoomTypes();
  }

  Future<void> fetchHotels() async {
    List<Map> hotelResponse = await sqlDb.readData("SELECT * FROM hotels");
    setState(() {
      hotelList = hotelResponse;
    });
  }

  Future<void> fetchRoomTypes() async {
    List<Map> roomTypeResponse = await sqlDb.readData("SELECT * FROM room_type");
    setState(() {
      roomTypeList = roomTypeResponse;
    });
  }

  // دالة لاختيار صور متعددة من المعرض
  Future<void> pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage(); // اختيار أكثر من صورة
    if (images == null || images.isEmpty) return;
    setState(() {
      pickedImages = images.map((image) => File(image.path)).toList(); // تحويل الصور إلى ملفات
    });
  }

Future<void> addImagesToDatabase() async {
  if (pickedImages.isEmpty || selectedHotelId == null || selectedRoomTypeId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('يرجى اختيار صورة وفندق ونوع الغرفة.')),
    );
    return;
  }

  // إضافة كل صورة على حدة والتحقق من النتيجة
  for (var pickedImage in pickedImages) {
    try {
      // قراءة الصورة وتحويلها إلى bytes
      Uint8List imageBytes = await pickedImage.readAsBytes();
      
      // إدخال الصورة إلى قاعدة البيانات
      int response = await sqlDb.insertDataimag(''' 
        INSERT INTO room_image (image_name, image, hotel_id, room_type_id)
        VALUES ("${pickedImage.path.split('/').last}", ?, $selectedHotelId, $selectedRoomTypeId)
      ''', [imageBytes]);

      // التحقق من نجاح الإدخال
      if (response > 0) {
        print('تم إضافة الصورة بنجاح: ${pickedImage.path}');
        // عرض رسالة تفيد بنجاح إضافة الصورة
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم إضافة الصورة: ${pickedImage.path}')),
        );
      } else {
        print('فشل إضافة الصورة: ${pickedImage.path}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل إضافة الصورة إلى قاعدة البيانات.')),
        );
      }
    } catch (e) {
      print('خطأ أثناء إضافة الصورة: ${pickedImage.path}. $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ أثناء إضافة الصورة.')),
      );
    }
  }

  // إعادة التوجيه إلى الشاشة الرئيسية بعد إضافة الصور
  Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => MyWidget(
                   
                  )),
          (route) => route.isFirst,
        );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("Add image room"),
      centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // عرض الصور المختارة
            pickedImages.isEmpty
                ? Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Center(child: Text('لم يتم اختيار صور')),
                  )
                : SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: pickedImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.file(
                            pickedImages[index],
                            height: 200,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: pickImages, // اختيار صور متعددة
              icon: const Icon(Icons.image),
              label: const Text('اختيار صور'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: selectedHotelId,
              hint: const Text('اختر الفندق'),
              items: hotelList.map((hotel) {
                return DropdownMenuItem<int>(
                  value: hotel['id'],
                  child: Text(hotel['hotel_name'] ?? 'اسم الفندق غير متاح'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedHotelId = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'الفندق',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: selectedRoomTypeId,
              hint: const Text('اختر نوع الغرفة'),
              items: roomTypeList.map((roomType) {
                return DropdownMenuItem<int>(
                  value: roomType['id'],
                  child: Text(roomType['room_type_name'] ?? 'اسم الغرفة غير متاح'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRoomTypeId = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'نوع الغرفة',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: addImagesToDatabase, // إضافة الصور إلى قاعدة البيانات
              icon: const Icon(Icons.save),
              label: const Text('إضافة الصور'),
            ),
          ],
        ),
      ),
    );
  }
}

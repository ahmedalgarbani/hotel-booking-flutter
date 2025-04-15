import 'package:flutter/material.dart';
import 'package:hotels/GTX/Models/database.dart';
import 'package:hotels/inserts/insertimageroom.dart';

class Insertroom extends StatefulWidget {
  final int? id;
  final String categoryName;
  const Insertroom({super.key, this.id, required this.categoryName});

  @override
  State<Insertroom> createState() => _InsertroomState();
}

class _InsertroomState extends State<Insertroom> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController maxCapacity = TextEditingController();
  TextEditingController roomAccount = TextEditingController();
  TextEditingController defaultcapacity = TextEditingController();

  List<Map> categoryList = [];
  List<Map> hotelList = [];
  bool isLoading = true;
  int? selectedCategoryId;
  int? selectedHotelId;

  Future readData() async {
    // قراءة البيانات من جدول الفنادق
    List<Map> hotelResponse = await sqlDb.readData("SELECT * FROM hotels");
    hotelList = hotelResponse;

    // قراءة البيانات من جدول الفئات
    List<Map> categoryResponse =
        await sqlDb.readData("SELECT * FROM categories");
    categoryList = categoryResponse;

    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    selectedCategoryId = widget.id;
    readData();
    super.initState();
  }

  addRoomType() async {
    if (formstate.currentState!.validate() &&
        selectedHotelId != null &&
        selectedCategoryId != null) {
      int response = await sqlDb.insertData('''
        INSERT INTO room_type ("room_type_name", "room_description", "max_capacity", "room_account","default_capacity", "hotel_id", "category_id")
        VALUES ("${title.text}", "${description.text}", ${int.parse(maxCapacity.text)}, ${int.parse(roomAccount.text)}, ${int.parse(defaultcapacity.text)},$selectedHotelId, $selectedCategoryId)
      ''');

      if (response > 0) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => InsertImageRoom(categoryName: '',)),
          (route) => route.isFirst,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Info room"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: formstate,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  TextFormField(
                    controller: title,
                    validator: (value) =>
                        value!.isEmpty ? "الرجاء إدخال اسم نوع الغرفة" : null,
                    decoration: InputDecoration(
                      labelText: 'اسم نوع الغرفة',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: description,
                    validator: (value) =>
                        value!.isEmpty ? "الرجاء إدخال وصف الغرفة" : null,
                    decoration: InputDecoration(
                      labelText: 'وصف الغرفة',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: maxCapacity,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? "الرجاء إدخال السعة القصوى" : null,
                    decoration: InputDecoration(
                      labelText: 'السعة القصوى',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: defaultcapacity,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? "الرجاء إدخال السعة القصوى" : null,
                    decoration: InputDecoration(
                      labelText: 'السعة الافتراضيه',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: roomAccount,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? "الرجاء إدخال عدد الغرف" : null,
                    decoration: InputDecoration(
                      labelText: 'عدد الغرف',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    value: selectedCategoryId,
                    hint: Text("اختار الفئة"),
                    items: categoryList.map((category) {
                      return DropdownMenuItem<int>(
                        value: category['id'],
                        child: Text(category['category_name'] ?? ''),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategoryId = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'الفئة',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    value: selectedHotelId,
                    hint: Text("اختار الفندق"),
                    items: hotelList.map((hotel) {
                      return DropdownMenuItem<int>(
                        value: hotel['id'],
                        child: Text(hotel['hotel_name'] ?? ''),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedHotelId = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'الفندق',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: addRoomType,
                    child: Text("إضافة نوع الغرفة"),
                  ),
                ],
              ),
            ),
    );
  }
}

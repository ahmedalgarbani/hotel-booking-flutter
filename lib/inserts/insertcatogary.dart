import 'package:flutter/material.dart';
import 'package:hotels/GTX/Models/database.dart';
import 'package:hotels/inserts/button.dart';

class AddbookWidg extends StatefulWidget {
  final int? id;
  final String categoryName;
  const AddbookWidg({super.key, this.id, required this.categoryName});

  @override
  State<AddbookWidg> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddbookWidg> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController title = TextEditingController();
  String? pdfPath;

  List<Map> categoryList = [];
  List<Map> hotelList = [];
  bool isLoading = true;
  int? selectedCategoryId;
  int? selectedHotelId;

  Future readData() async {
    List<Map> hotelResponse = await sqlDb.readData("SELECT * FROM hotels");
    hotelList = hotelResponse;

    List<Map> categoryResponse =
        await sqlDb.readData("SELECT * FROM categories");
    categoryList = categoryResponse;

    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void initState() {
    selectedCategoryId = widget.id;
    print(selectedCategoryId);
    readData();
    super.initState();
  }

  addCategory() async {
    if (selectedHotelId != null && title.text.isNotEmpty) {
      int response = await sqlDb.insertData('''
        INSERT INTO categories ("category_name", "hotel_id")
        VALUES ("${title.text}", "$selectedHotelId")
      ''');

      if (response > 0) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => MyWidget(
                   
                  )),
          (route) => route.isFirst,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add catogary"),
      centerTitle: true,),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  height: 350,
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              child: TextField(
                                textDirection: TextDirection.rtl,
                                controller: title,
                                decoration: InputDecoration(
                                  labelText: ' اسم الفئه',
                                  labelStyle: TextStyle(),
                                  floatingLabelAlignment:
                                      FloatingLabelAlignment.center,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 27, 43, 78)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                      color: Colors.green,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 23, 35, 61),
                                        width: 2.0),
                                  ),
                                  alignLabelWithHint: true,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              child: DropdownButtonFormField<int>(
                                hint: Text(
                                  "اختار الفندق",
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                alignment: Alignment.center,
                                value: selectedHotelId,
                                items: hotelList.map((hotel) {
                                  return DropdownMenuItem<int>(
                                    value: hotel['id'],
                                    child: Text(
                                      hotel['hotel_name'] ??
                                          'اسم الفندق غير متاح',
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedHotelId = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'الفندق',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  floatingLabelAlignment:
                                      FloatingLabelAlignment.center,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 37, 38, 82),
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                      color: Colors.green,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 23, 35, 61),
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.green,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  addCategory(); 
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      " اضافة فئه",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

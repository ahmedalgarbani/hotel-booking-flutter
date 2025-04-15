import 'package:flutter/material.dart';
import 'package:hotels/GTX/Models/database.dart';

class AddAvailabilityWidget extends StatefulWidget {
  const AddAvailabilityWidget({Key? key}) : super(key: key);

  @override
  State<AddAvailabilityWidget> createState() => _AddAvailabilityWidgetState();
}

class _AddAvailabilityWidgetState extends State<AddAvailabilityWidget> {
  SqlDb sqlDb = SqlDb();

  List<Map> hotelList = [];
  List<Map> roomTypeList = [];
  bool isLoading = true;

  int? selectedHotelId;
  int? selectedRoomTypeId;
  TextEditingController availableRoomsController = TextEditingController();
  TextEditingController availabilityDateController = TextEditingController();
  TextEditingController priceController =
  TextEditingController(); 

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    hotelList = await sqlDb.readData("SELECT * FROM hotels");
    roomTypeList = await sqlDb.readData("SELECT * FROM room_type");
    isLoading = false;
    setState(() {});
  }

  Future<void> addAvailability() async {
    if (selectedHotelId != null &&
        selectedRoomTypeId != null &&
        availableRoomsController.text.isNotEmpty &&
        availabilityDateController.text.isNotEmpty) {
      try {
        int response = await sqlDb.insertData('''
        INSERT INTO availability (
          availability_date,
          available_rooms,
          hotel_id,
          room_type_id
        ) VALUES (
          "${availabilityDateController.text}",
          ${int.parse(availableRoomsController.text)},
          $selectedHotelId,
          $selectedRoomTypeId
        )
      ''');

        if (response > 0) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("تمت الإضافة بنجاح!"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("حدث خطأ أثناء الإضافة"),
            backgroundColor: Colors.red,
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("خطأ: ${e.toString()}"),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("الرجاء تعبئة كافة الحقول"),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        availabilityDateController.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إضافة التوافر"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButtonFormField<int>(
                    hint: Text("اختر الفندق"),
                    value: selectedHotelId,
                    items: hotelList.map((hotel) {
                      return DropdownMenuItem<int>(
                        value: hotel['id'],
                        child:
                            Text(hotel['hotel_name'] ?? 'اسم الفندق غير متاح'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedHotelId = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    hint: Text("اختر نوع الغرفة"),
                    value: selectedRoomTypeId,
                    items: roomTypeList.map((roomType) {
                      return DropdownMenuItem<int>(
                        value: roomType['id'],
                        child: Text(roomType['room_type_name'] ??
                            'نوع الغرفة غير متاح'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRoomTypeId = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: availabilityDateController,
                    readOnly: true,
                    onTap: selectDate,
                    decoration: InputDecoration(
                      labelText: "تاريخ التوافر",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: availableRoomsController,
                    decoration: InputDecoration(
                      labelText: "عدد الغرف المتوفرة",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  // TextField(
                  //   controller: priceController, // حقل السعر الجديد
                  //   decoration: InputDecoration(
                  //     labelText: "السعر",
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   keyboardType: TextInputType.number,
                  // ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: addAvailability,
                    child: Text("إضافة التوافر"),
                  ),
                ],
              ),
            ),
    );
  }
}

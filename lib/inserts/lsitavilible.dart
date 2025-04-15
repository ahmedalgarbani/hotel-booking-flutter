import 'package:flutter/material.dart';
import 'package:hotels/GTX/Models/database.dart';

class AvailabilityListWidget extends StatefulWidget {
  const AvailabilityListWidget({Key? key}) : super(key: key);

  @override
  _AvailabilityListWidgetState createState() => _AvailabilityListWidgetState();
}

class _AvailabilityListWidgetState extends State<AvailabilityListWidget> {
  SqlDb sqlDb = SqlDb();
  List<Map> availabilityList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    availabilityList = await sqlDb.readData("SELECT * FROM availability");
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("قائمة التوافر"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: availabilityList.length,
              itemBuilder: (context, index) {
                var availability = availabilityList[index];
                return ListTile(
                  title: Text(
                    'الفندق: ${availability['hotel_id']} | نوع الغرفة: ${availability['room_type_id']}',
                  ),
                  subtitle: Text(
                    'تاريخ التوافر: ${availability['availability_date']} | الغرف المتوفرة: ${availability['available_rooms']}',
                  ),
                );
              },
            ),
    );
  }
}

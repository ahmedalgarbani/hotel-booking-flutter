import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/counter_Controller.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Booking> {
  TextEditingController dateRangeController = TextEditingController();

  Future<void> selectDateRange() async {
    final DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2025, 1, 1),
      lastDate: DateTime(2030, 1, 1),
      currentDate: DateTime.now(),
      saveText: 'Save',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // اللون الأساسي
              onPrimary: Colors.white, // لون النص على الزر
              onSurface: Colors.black, // لون النص على السطح
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDateRange != null) {
      setState(() {
        dateRangeController.text =
            "${pickedDateRange.start.year}-${pickedDateRange.start.month.toString().padLeft(2, '0')}-${pickedDateRange.start.day.toString().padLeft(2, '0')} إلى "
            "${pickedDateRange.end.year}-${pickedDateRange.end.month.toString().padLeft(2, '0')}-${pickedDateRange.end.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: TextButton(
            onPressed: () {
              bottunSheet(context, dateRangeController, selectDateRange);
            },
            child: Text("Booking")),
      ),
    );
  }
}

Future bottunSheet(
  BuildContext context,
  TextEditingController dateRangeController,
  Future<void> Function() selectDateRange,
) {
  return showModalBottomSheet(
    context: context,
    builder: (ctx) => SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            GetX<CounterController>(
              builder: (_counter) => Column(
                children: [
                  // Room Counter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Room"),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _counter.decrementCounter();
                              },
                              icon: Icon(Icons.remove),
                            ),
                            Text(_counter.counters.value.toString()),
                            IconButton(
                              onPressed: () {
                                _counter.increament();
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Guest Counter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Guest"),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _counter.decrementCounterQuests();
                              },
                              icon: Icon(Icons.remove),
                            ),
                            Text(_counter.counterQuest.value.toString()),
                            IconButton(
                              onPressed: () {
                                _counter.incrementCounterQuests();
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Date Range Picker
            TextField(
              controller: dateRangeController,
              readOnly: true,
              onTap: selectDateRange,
              decoration: InputDecoration(
                labelText: "Range Date",
                border: OutlineInputBorder(),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color.fromRGBO(21, 37, 65, 1),
                border: Border.all(),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

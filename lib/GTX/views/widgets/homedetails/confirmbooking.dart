import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/controller/counter_Controller.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/views/screens/exchange.dart';
import 'package:http/http.dart';

Future bottunSheet({
  required BuildContext context,
  required int indexhotel,
  required int indexroom,
  required int id,
}) {
  final ConfirmController bookingController = Get.find();
  final CounterController counterController = Get.find();
  final dateRange = "${bookingController.check_in_date}" +
      "${bookingController.check_out_date}";

  return showModalBottomSheet(
    context: context,
    builder: (ctx) => SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            GetX<ConfirmController>(
              builder: (counter) => Column(
                children: [
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
                              onPressed: counter.decrementCounter,
                              icon: Icon(Icons.remove),
                            ),
                            Text(counter.counters.value.toString()),
                            IconButton(
                              onPressed: counter.increament,
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // عداد الضيوف
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
                              onPressed: counter.decrementCounterQuests,
                              icon: Icon(Icons.remove),
                            ),
                            Text(counter.counterQuest.value.toString()),
                            IconButton(
                              onPressed: counter.incrementCounterQuests,
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
            GetX<ConfirmController>(
                builder: (bookingController) => TextField(
                      readOnly: true,
                      onTap: bookingController.isLoading.value
                          ? null
                          : () => bookingController.selectDateRange(context),
                      decoration: InputDecoration(
                        labelText: "Range Date",
                        border: OutlineInputBorder(),
                        hintText: bookingController.check_in_date.isEmpty ||
                                bookingController.check_out_date.isEmpty
                            ? "Select Date Range"
                            : "${bookingController.check_in_date.value} - ${bookingController.check_out_date.value}",
                      ),
                    )),
            Container(
                margin: EdgeInsets.all(4),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Color.fromARGB(220, 7, 86, 152),
                  border: Border.all(),
                ),
                child: TextButton(
                  onPressed: () async {
                    await bookingController.makeBooking(
                      amount: double.parse(bookingController.amount.value),
                      hotelId: int.parse(bookingController.hotel_id.value),
                      roomId: int.parse(bookingController.room_id.value),
                      checkInDate: bookingController.check_in_date.value,
                      checkOutDate: bookingController.check_out_date.value,
                      roomsBooked: bookingController.counters.value,
                      context: context,
                    );

                    // await bookingController.makeBooking(
                    //   amount: 500,
                    //   hotelId: int.parse(bookingController.hotel_id.value),
                    //   roomId: int.parse(bookingController.room_id.value),
                    //   checkInDate: bookingController.check_in_date.value,
                    //   checkOutDate: bookingController.check_out_date.value,
                    //   roomsBooked: bookingController.counters.value,
                    //   context: context,
                    // );
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ],
        ),
      ),
    ),
  );
}

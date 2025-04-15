import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/controller/gotherAllvaraiblepay_controller.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/controller/paymentOption_Cotroller.dart';
import 'package:hotels/GTX/views/widgets/paymentswidget/payment_account.dart';
import 'package:image_picker/image_picker.dart';

class ExchangeApp extends StatelessWidget {
  final int indexhotel;
  ExchangeApp({required this.indexhotel});

  final PaymentOptionController paymentController = PaymentOptionController();
  // final ConfirmController confirmController = Get.find();
  final ConfirmController confirmController = Get.find<ConfirmController>();
  final GotherallvaraiblepayController posPaymrntcontroller =
      Get.find<GotherallvaraiblepayController>();

  final Hotelinfo hotelinfo = Get.find();

  @override
  Widget build(BuildContext context) {
    paymentController.fetchPayment(indexhotel);

    return Scaffold(
      appBar: AppBar(
        title: Text('اختيار صراف', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(239, 7, 86, 152),
        centerTitle: true,
      ),
      body: Obx(() {
        if (paymentController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (paymentController.paymentOptionList.isEmpty) {
          return Center(child: Text("لا توجد بيانات متاحة"));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                final booking = confirmController.bookingData;
                if (hotelinfo.hotel_name.value.isEmpty) {
                  return Text("لا يوجد حجز حالي.");
                }

                return bookingHotel(
                  hotel_name: hotelinfo.hotel_name.value,
                  room_name: hotelinfo.room_name.value,
                  check_in_date: confirmController.check_in_date.value,
                  check_out_date: confirmController.check_out_date.value,
                  rooms_booked: confirmController.counter.toString(),
                  amount: confirmController.amount.value,
                  imagePath: hotelinfo.image_hotel.value,
                );
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text("رقم الحجز: ${booking['rooms_booked']}"),
                //     Text("الفندق: ${booking['hotel_name']}"),
                //     Text("الغرفة: ${booking['room_name']}"),
                //     Text("المبلغ: ${booking['amount']} ريال"),
                //     Text("من: ${booking['check_in_date']}"),
                //     Text("إلى: ${booking['check_out_date']}"),
                //   ],
                // );
              }),
              SizedBox(height: 15),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: paymentController.paymentOptionList.length,
                  itemBuilder: (context, index) {
                    var payment = paymentController.paymentOptionList[index];
                    return Obx(() {
                      return InkWell(
                        onTap: () {
                          paymentController.updateSelectedPayment(
                              index, payment);

                         posPaymrntcontroller.paymentMethodId.value = payment.id;

                          // print(
                          //     "paymentController.description ${paymentController.paymentMethodId}");
                        },
                        child: exchange(
                          namemethod: payment.paymentOption.methodName,
                          image: payment.paymentOption.logo,
                          isSelected:
                              paymentController.selectedIndex.value == index,
                        ),
                      );
                    });
                  },
                ),
              ),
              SizedBox(height: 15),
              Obx(() {
                if (paymentController.selectedIndex.value != -1) {
                  return RadioListTile<String>(
                    title: Text(paymentController
                        .paymentOptionList[
                            paymentController.selectedIndex.value]
                        .paymentOption
                        .currency
                        .currencyName),
                    value: paymentController
                        .paymentOptionList[
                            paymentController.selectedIndex.value]
                        .paymentOption
                        .currency
                        .currencyName,
                    groupValue: paymentController.selectedCurrency.value,
                    onChanged: (value) {
                      paymentController.selectedCurrency.value = value!;
                      posPaymrntcontroller.selectedCurrency.value=paymentController.selectedCurrency.value;

                    },
                  );
                } else {
                  return SizedBox();
                }
              }),
              Obx(() {
                return accountInfo(
                    iban: paymentController.iban.value,
                    description: paymentController.description.value,
                    numberAccount: paymentController.numberAccount.value,
                    nameAccount: paymentController.nameAccount.value);
              }),
              // ImagePickers(),

              accountTextField(),
            ],
          ),
        );
      }),
      bottomNavigationBar: bottomButton(context),
    );
  }
}

// Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     Text("رقم الحجز: ${booking['id']}"),
//     Text("الفندق: ${booking['hotel_name']}"),
//     Text("الغرفة: ${booking['room']}"),
//     Text("المبلغ: ${booking['amount']} ريال"),
//     Text("من: ${booking['check_in_date']}"),
//     Text("إلى: ${booking['check_out_date']}"),
//   ],
// );

Widget bookingHotel({
  required String hotel_name,
  required String room_name,
  required String check_in_date,
  required String check_out_date,
  required String rooms_booked,
  required String amount,
  required String imagePath,
}) {
  return Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          offset: Offset(1, 1),
          blurRadius: 5,
          spreadRadius: 2,
          blurStyle: BlurStyle.normal,
          color: Colors.grey.withOpacity(0.2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // صورة الفندق
        Container(
          margin: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imagePath,
              height: 140,
              width: 75,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.broken_image),
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        hotel_name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          overflow: TextOverflow
                              .ellipsis, // تجنب التمرير عند زيادة النص
                        ),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                  ],
                ),

                SizedBox(height: 5),

                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 18,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        room_name,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                  children: [
                    Text(
                      "$amount",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '/night',
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ],
                ),

                // خط فاصل
                Divider(
                  color: Colors.grey.withOpacity(0.4),
                  thickness: 1,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: Colors.grey,
                          size: 18,
                        ),
                        SizedBox(width: 5),
                        Text("Date:",
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        SizedBox(width: 5),
                        Text("${check_in_date} - ${check_out_date}",
                            style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        SizedBox(width: 5),
                        Text("Guest:",
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        SizedBox(width: 5),
                        Text("2 Guests (${rooms_booked} room)",
                            style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

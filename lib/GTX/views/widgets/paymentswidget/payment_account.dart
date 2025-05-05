import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/PaymentController.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/controller/gotherAllvaraiblepay_controller.dart';
import 'package:hotels/GTX/controller/paymentOption_Cotroller.dart';
import 'package:hotels/GTX/services/postPaymentModel.dart';

Widget exchange(
    {required String image,
    required String namemethod,
    required bool isSelected,
    required BuildContext context}) {
  return Container(
    margin: EdgeInsets.only(left: 9, right: 9),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: isSelected ? Color.fromARGB(239, 7, 86, 152) : Colors.grey,
        width: 2,
      ),
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            image,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.broken_image),
          ),
        ),
        Text(namemethod),
      ],
    ),
  );
}

Widget accountInfo(
    {required String iban,
    required String description,
    required String numberAccount,
    required String nameAccount,
    required BuildContext context}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Theme.of(context).colorScheme.secondary,
      gradient: LinearGradient(
        colors: [
          Colors.lightBlue.withOpacity(0.6),
          Color.fromARGB(220, 7, 86, 152),
          Colors.lightBlueAccent.withOpacity(0.7),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: Offset(1, 1),
          blurRadius: 6,
        ),
      ],
    ),
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(15),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            accountDetail("Account Name", nameAccount),
            accountDetail("Account Number", numberAccount),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            accountDetail("IBAN", iban),
            accountDetail("Description", description),
          ],
        ),
      ],
    ),
  );
}

Widget accountDetail(String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title.tr,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16)),
      Text(value,
          style: TextStyle(
              color: Colors.grey[200],
              fontWeight: FontWeight.bold,
              fontSize: 12)),
    ],
  );
}

Widget accountInfoImageAndTypePay(BuildContext context) {
  final GotherallvaraiblepayController paymentTyoe =
      Get.find<GotherallvaraiblepayController>();
  return GetX<ConfirmController>(
    builder: (controller) => controller.isLoading.value
        ? Center(child: CircularProgressIndicator())
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.secondary,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: DropdownButton<String>(
                      dropdownColor: Theme.of(context).colorScheme.background,
                      value: paymentTyoe.paymentType.value,
                      isExpanded: true,
                      underline: SizedBox(),
                      items: [
                        DropdownMenuItem(value: "cash", child: Text("cash".tr)),
                        DropdownMenuItem(
                            value: "e_pay", child: Text("e_pay".tr)),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          paymentTyoe.paymentType.value = value;
                          print(paymentTyoe.paymentType.value);
                        }
                      },
                    ),
                  ),
                ),
              ),

              // اختيار صورة السند
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () async {
                      await controller.fetchImageDialog();
                    },
                    child: GestureDetector(
                      onLongPress: () {
                        Get.dialog(
                          Dialog(
                            backgroundColor: Colors.transparent,
                            child: InteractiveViewer(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  controller.pickedimage.value!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: controller.pickedimage.value != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  controller.pickedimage.value!,
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.upload,
                                        size: 40, color: Colors.grey),
                                    SizedBox(height: 8),
                                    Text("اختر صورة السند",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.color)),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
  );
}

Widget ImagePickers() {
  return GetX<ConfirmController>(
    builder: (controller) {
      final image = controller.pickedimage.value;
      return Container(
        margin: EdgeInsets.all(10),
        child: image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  image,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              )
            : const Text("لم يتم اختيار صورة"),
      );
    },
  );
}

Widget bottomButton(BuildContext context) {
  final PaymentOptionController controller =
      Get.find<PaymentOptionController>();
  final ConfirmController bookingController = Get.find<ConfirmController>();
  final gotherallvaraiblepay = Get.find<GotherallvaraiblepayController>();
  final paymentController = Get.find<PaymentController>();
  return Container(
    margin: EdgeInsets.all(9),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextButton(
      onPressed: () async {
        await gotherallvaraiblepay.printallVaribale();

        if (gotherallvaraiblepay.selectedCurrency.value == null ||
            gotherallvaraiblepay.selectedCurrency.value == '') {
          Get.snackbar("خطأ", "يرجى اختيار العملة");
          return;
        } else if (bookingController.pickedimage.value == null) {
          Get.snackbar("خطأ", "يرجى اختيار صورة التحويل البنكي");
          return;
        }
        

        await paymentController.makePayment(
          bookingId: gotherallvaraiblepay.bookingId.value,
          paymentMethodId: gotherallvaraiblepay.paymentMethodId.value,
          paymentSubtotal:
              double.parse(gotherallvaraiblepay.paymentSubtotal.value),
          paymentTotalAmount:
              double.parse(gotherallvaraiblepay.paymentTotalAmount.value),
          paymentCurrency: gotherallvaraiblepay.selectedCurrency.value,
          paymentType: gotherallvaraiblepay.paymentType.value,
          transferImage: bookingController.pickedimage.value!,
          paymentNote: "booking",
          paymentDiscount: "0",
          paymentStatus: 1,
        );
      },
      child: Text("إكمال",
          style:
              TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
    ),
  );
}

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
                          overflow: TextOverflow.ellipsis,
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
                        Text("Date:".tr,
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
                        Text("Guest:".tr,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/Booking_details_Controller.dart';

class GuestInfoScreen extends StatefulWidget {
  final int bookingId;

  const GuestInfoScreen({super.key, required this.bookingId});

  @override
  State<GuestInfoScreen> createState() => _GuestInfoScreenState();
}

class _GuestInfoScreenState extends State<GuestInfoScreen> {
  @override
  void initState() {
    super.initState();
    final controller = Get.find<BookingController>();
    controller.loadBookingDetailsById(widget.bookingId); 
  }

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.find<BookingController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("بيانات الضيوف", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() {
       if (controller.bookingGuest.isEmpty) {
        
                    return Center(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.amber.shade100,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(
                            alignment: Alignment.center,
                            width: 300,
                            height: 220,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "😊",
                                  style: TextStyle(fontSize: 48),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "لا يتوفر ضيوف لهذا الحجز حالياً",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  
        }

        return ListView.builder(
          itemCount: controller.bookingGuest.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final guest = controller.bookingGuest[index];
            return Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.only(bottom: 20),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    if (guest.idCardImage != null && guest.idCardImage!.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          guest.idCardImage!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      const Icon(Icons.person, size: 80, color: Colors.grey),

                    const SizedBox(height: 12),

                    _infoRow("الاسم", guest.name),
                    _infoRow("رقم الهاتف", guest.phoneNumber),
                    _infoRow("الجنس", guest.gender),
                    _infoRow("تاريخ الميلاد", guest.birthdayDate),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.teal),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value.isEmpty ? "غير متوفر" : value, 
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

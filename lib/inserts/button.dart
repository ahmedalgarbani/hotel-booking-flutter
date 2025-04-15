import 'package:flutter/material.dart';
import 'package:hotels/GTX/views/screens/mainpagescreens/homepage.dart';
import 'package:hotels/inserts/avaibility.dart';
import 'package:hotels/inserts/insertcatogary.dart';
import 'package:hotels/inserts/inserthotel.dart';
import 'package:hotels/inserts/insertimageroom.dart';
import 'package:hotels/inserts/insertroom.dart';
import 'package:hotels/inserts/lsitavilible.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Four Buttons"),
        automaticallyImplyLeading: false, // التحكم في ظهور زر الرجوع الافتراضي
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // العودة إلى الشاشة الرئيسية
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AddcatogaryWidget()),
                  (route) => route.isFirst,
                );
              },
              child: const Text("add hotel"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => AddbookWidg(
                            categoryName: '',
                          )),
                  (route) => route.isFirst,
                );
              },
              child: const Text("Add catogaryn "),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // إجراء عند الضغط على الزر الثالث
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => Insertroom(
                            categoryName: '',
                          )),
                  (route) => route.isFirst,
                );
              },
              child: const Text("Add room"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => InsertImageRoom(
                            categoryName: '',
                          )),
                  (route) => route.isFirst,
                );
              },
              child: const Text("Add image rooms"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(builder: (context) => Homepage()),
                //   (route) => route.isFirst,
                // );
              },
              child: const Text("Home page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => AddAvailabilityWidget()),
                  (route) => route.isFirst,
                );
              },
              child: const Text("AddAvailability"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => AvailabilityListWidget()),
                  (route) => route.isFirst,
                );
              },
              child: const Text("show avibility"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/list.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/controller/Booking_details_Controller.dart';
import 'package:hotels/GTX/controller/Controller_favourites.dart';
import 'package:hotels/GTX/controller/PaymentController.dart';
import 'package:hotels/GTX/controller/Register_Controll.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/controller/counter_Controller.dart';
import 'package:hotels/GTX/controller/deleteFavouritesController.dart';
import 'package:hotels/GTX/controller/gotherAllvaraiblepay_controller.dart';
import 'package:hotels/GTX/controller/hotelLocation_Controller.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/controller/login_controller.dart';
import 'package:hotels/GTX/controller/paymentOption_Cotroller.dart';
import 'package:hotels/GTX/controller/search_controller.dart';
import 'package:hotels/GTX/services/getBookinService.dart';
import 'package:hotels/GTX/views/screens/exchange.dart';
import 'package:hotels/GTX/views/screens/mainpagescreens/homepage.dart';
import 'package:hotels/GTX/views/widgets/registers/mainregisre.dart';
import 'package:geolocator/geolocator.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MyApp(),
  );
//   DevicePreview(
//     //   // enabled: true,
//     //   builder: (context) =>
//     // ),
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    Get.put(BookingController());
    Get.put(HotelsController());

    Get.put(ConfirmController());
    Get.put(PaymentController());
    Get.put(RegistrationController());
    Get.put(Hotelinfo());
    Get.put(CounterController());
    Get.put(ListControle());
    Get.put(SearchHotelController());

    Get.put(getBookingService());

    Get.put(FavouritesController());
    Get.put(PaymentOptionController());
    Get.put(SignupController());
    Get.put(Deletefavouritescontroller());
    Get.put(GotherallvaraiblepayController());

    return GetMaterialApp(
      // builder: DevicePreview.appBuilder, // دمج المعاينة
      // locale: DevicePreview.locale(context),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: const Color.fromARGB(255, 131, 31, 51),
          unselectedItemColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        // cardColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Homepage(),
      routes: {
        // "/dashboard": (context) => Dashboard(),  // الصفحة الرئيسية بعد تسجيل الدخول
        // "/login": (context) => SignupScreen(),  // صفحة تسجيل الدخول
        "/login": (context) =>
            LoginScreen(), // أي صفحة أخرى تريد تحويل المستخدم إليها
      },
    );
  }
}




// class ThirdPage extends StatefulWidget {
//   const ThirdPage({super.key});

//   @override
//   _ThirdPageState createState() => _ThirdPageState();
// }

// class _ThirdPageState extends State<ThirdPage> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Third Page"),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: [
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Text(
//                   'Welcome to the Third Page !',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//           Favoritescreen(),
//           Bookingscreen(),
//           Mainregisre(),
//         ],
//       ),
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Colors.white,
//         color: const Color.fromRGBO(21, 37, 65, 1),
//         buttonBackgroundColor: const Color.fromRGBO(21, 37, 65, 1),
//         height: 60,
//         items: const [
//           Icon(
//             Icons.home,
//             color: Colors.white,
//             size: 30,
//           ),
//           Icon(
//             Icons.favorite,
//             color: Colors.white,
//             size: 30,
//           ),
//           Icon(
//             Icons.hotel,
//             color: Colors.white,
//             size: 30,
//           ),
//         ],
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }



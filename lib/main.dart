import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/list.dart';
import 'package:hotels/GTX/Models/rigetermodel.dart';
import 'package:hotels/GTX/controller/Booking_details_Controller.dart';
import 'package:hotels/GTX/controller/ChangePasswordController.dart';
import 'package:hotels/GTX/controller/Controller_favourites.dart';
import 'package:hotels/GTX/controller/NotificationsController.dart';
import 'package:hotels/GTX/controller/PaymentController.dart';
import 'package:hotels/GTX/controller/Register_Controll.dart';
import 'package:hotels/GTX/controller/ThemeController.dart';
import 'package:hotels/GTX/controller/categoriesController.dart';
import 'package:hotels/GTX/controller/confirm_Contlloer.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/controller/counter_Controller.dart';
import 'package:hotels/GTX/controller/deleteFavouritesController.dart';
import 'package:hotels/GTX/controller/gotherAllvaraiblepay_controller.dart';
import 'package:hotels/GTX/controller/hotelLocation_Controller.dart';
import 'package:hotels/GTX/controller/hotelinf.dart';
import 'package:hotels/GTX/controller/login_controller.dart';
import 'package:hotels/GTX/controller/paymentOption_Cotroller.dart';
import 'package:hotels/GTX/controller/search_controller.dart';
import 'package:hotels/GTX/controller/showProfileinfo.dart';
import 'package:hotels/GTX/controller/updateprofilecontroller.dart';
import 'package:hotels/GTX/services/getBookinService.dart';
import 'package:hotels/GTX/thems.dart';
import 'package:hotels/GTX/views/screens/mainpagescreens/homepage.dart';
import 'package:hotels/GTX/views/screens/mybookingscreen/bookingscreen.dart';
import 'package:hotels/GTX/views/widgets/ConnectionCheckWidget/ConnectionCheckWidget.dart';
import 'package:hotels/GTX/views/widgets/registers/AuthSelectionScreen.dart';

import 'package:hotels/Translate/app_translations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
    ThemeMode _themeMode = ThemeMode.system; // متغير داخل Controller مثلاً أو في State
 final Rigetermodel user;



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
    Get.put(GotherallvaraiblepayController());
    Get.put(Categoriescontroller());
    Get.put(Updateprofilecontroller());
    Get.put(Showprofileinfo());
    Get.put(ChangePasswordController());
    // Get.put(NetworkController());
    Get.put(NotificationsController());
   final themeController= Get.put(ThemeController());
       final NetworkController connectivityController = Get.put(NetworkController());



    return Obx(() => GetMaterialApp(
  debugShowCheckedModeBanner: false,
  theme: lightMode,
  darkTheme: darkMode,
  themeMode: themeController.themeMode.value,
  translations: AppTranslations(),
  locale: const Locale('ar', 'SA'),
  fallbackLocale: const Locale('en', 'US'),
  home: Homepage(), 
  builder: (context, child) {
    return Stack(
      children: [
        child!,
        Obx(() {
          if (!connectivityController.isConnected.value) {
            return ConnectionCheckWidget(); 
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  },
  routes: {
    "/login": (context) => AuthSelectionScreen(),
    "/bookings": (context) => Bookingscreen(),
    "/homepage": (context) => Homepage(),
  },
));

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



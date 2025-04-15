// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class LocationService {
//   static Future<Position> getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       throw Exception(" خدمة الموقع غير مفعلة. الرجاء تفعيل GPS.");
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception("تم رفض إذن الموقع من قبل المستخدم.");
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       throw Exception("🚫 تم رفض إذن الموقع نهائيًا. الرجاء تفعيله من الإعدادات.");
//     }

//     return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   }
// }

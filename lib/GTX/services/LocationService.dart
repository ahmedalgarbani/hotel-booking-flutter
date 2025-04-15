import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  Future<String> getCurrentCity() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception("خدمة الموقع غير مفعّلة");

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("تم رفض صلاحية الموقع");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("تم رفض صلاحية الموقع بشكل دائم");
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    return placemarks.isNotEmpty
        ? (placemarks.first.locality ?? "غير معروف")
        : "غير معروف";
  }
}


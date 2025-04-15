import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ListControle extends GetxController {
  final List<Map<String, String>> hotelData = [
    {
      "name": "Hotel Sana'a",
      "location": "Sana'a",
      "price": r"$660",
      "imagePath": "assets/istockphoto-1404624485-612x612.jpg",
    },
    {
      "name": "Hotel Kitab",
      "location": "AL-garyai",
      "price": r"$850",
      "imagePath": "assets/istockphoto-1404624485-612x612.jpg",
    },
    {
      "name": "Hotel IBB",
      "location": "ALmadainah",
      "price": r"$500",
      "imagePath": "assets/hotel.png",
    },
    {
      "name": "Hotel IBB",
      "location": "ALmadainah",
      "price": r"$500",
      "imagePath": "assets/istockphoto-1404624485-612x612.jpg",
    },
    {
      "name": "Hotel IBB",
      "location": "ALmadainah",
      "price": r"$500",
      "imagePath": "assets/hotel.png",
    },
  ];

  final List<Map<String, String>> cityData = [
    {
      "image": "assets/istockphoto-1404624485-612x612.jpg",
      "name": "Sana'a",
      "date": "12 Apr 2023"
    },
    {"image": "assets/hotel.png", "name": "Aden", "date": "14 Apr 2023"},
    {"image": "assets/hotel.png", "name": "Taiz", "date": "15 Apr 2023"},
    {"image": "assets/hotel.png", "name": "Hodeidah", "date": "16 Apr 2023"},
    {"image": "assets/hotel.png", "name": "Ibb", "date": "18 Apr 2023"},
  ];

  List imageList = [
    'assets/dubai-sun-sands-sea-view-hotel-picture-12.jpg',
    'assets/istockphoto-1404624485-612x612.jpg',
    'assets/png-clipart-hotel-outdoor-recreation-area-five-star-hotel.png',
    'assets/istockphoto-1404624485-612x612.jpg',
    'assets/hotel.png',
    'assets/imagesssss.jpg',
    'assets/images.jpg',
  ];
}

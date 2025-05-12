import 'package:get/get.dart';
import 'package:hotels/GTX/Models/show_hotel_model.dart';
import 'package:hotels/GTX/services/hotel_review_service.dart';
import 'package:hotels/GTX/services/show_hotel_services.dart';

class SortedHotelReviewController extends GetxController {
 
  var hotelsListSorted = <HotelsModel>[].obs;
  var hotelroom = <modelRoomm>[].obs;
  var reviewHotel = <ReviewModel>[].obs;
  var Servicehotel = <ModelService>[].obs;

  var hotel_name = "".obs;
  var image_hotel = "".obs;
  var room_name = "".obs;
  var hotelroomService = <modelServiceModel>[].obs;
  var selectedExtraServices = <int>[].obs;
  var hotelroomimage = <modelRoomImagee>[].obs;
  var isFetching = false.obs;
  var isFavorite = false.obs;

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  @override
  void onInit() {
    super.onInit();
    // toggleFavorite();
    fetchHotelsorteds();
    // fetchHotelsRievew();
  }

  void sortHotelsByAverageRating() {
    hotelsListSorted.sort((a, b) {
      double avgA = _calculateAverageRating(a);
      double avgB = _calculateAverageRating(b);
      return avgB.compareTo(avgA);
    });
  }

  double _calculateAverageRating(HotelsModel hotel) {
    if (hotel.reviews.isEmpty) return 0.0;

    final review = hotel.reviews.first;
    return (review.ratingCleanliness +
            review.ratingLocation +
            review.ratingService +
            review.ratingValueForMoney) /
        4;
  }

  void fetchHotelsorteds() async {
    isFetching.value = true;
    try {
      List<HotelsModel> fetchedHotels = await GetAllHotels().getAllHotels();
          hotelsListSorted.value = fetchedHotels;
      sortHotelsByAverageRating();
    } catch (e) {
      print("Error fetching data: $e");
      hotelsListSorted.clear();
    } finally {
      isFetching.value = false;
    }
    update();
  }

  // void fetchHotelsRievew() async {
  //   isFetching.value = true;
  //   try {
  //     List<HotelsModel> fetchedHotels = await GetAllHotels().getAllHotels();

  //     hotelsListSorted.value = fetchedHotels;
  //     sortHotelsByAverageRating();
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //     // hotelsList.clear();
  //     hotelsListSorted.clear();
  //   } finally {
  //     isFetching.value = false;
  //   }
  //   update();
  // }

  void loadHotelRoomsById(int hotelId) {
    final hotel = hotelsListSorted.firstWhereOrNull((h) => h.id == hotelId);

    if (hotel != null) {
      hotel_name.value = hotel.name;
      hotel_name.value = hotel.name;
      image_hotel.value = hotel.image;
      hotelroom.value = hotel.rooms;
      // for (var element in hotelroom) {
      //   print(element);

      // }

      reviewHotel.value = hotel.reviews;
      Servicehotel.value = hotel.services;
      Servicehotel.value = hotel.services;
    } else {
      hotelroom.clear();
      reviewHotel.clear();
      Servicehotel.clear();
    }
  }

  // void loadHotelreviewHotelById(int hotelId) {
  //   final hotel = hotelsList.firstWhereOrNull((h) => h.id == hotelId);
  //   if (hotel != null) {
  //     image_hotel.value = hotel.image;
  //     reviewHotel.value = hotel.reviews;

  //       reviewHotel.forEach((room) {
  //     print("معرف : ${room.id}");
  //     print("اسم : ${room.ratingCleanliness}");
  //     print("السعة : ${room.ratingService}");
  //     print("السعر : ${room.ratingLocation}");
  //     print("----");
  //   });
  //   } else {
  //     reviewHotel.clear();
  //   }
  // }

  void loadHotelRoomsServiceById(int room_id) {
    final rooms = hotelroom.firstWhereOrNull((h) => h.id == room_id);
    if (rooms != null) {
      room_name.value = rooms.name;
      hotelroomService.value = rooms.services;
    } else {
      hotelroomService.clear();
    }
  }

  void loadHotelRoomsImageById(int room_id) {
    final rooms = hotelroom.firstWhereOrNull((h) => h.id == room_id);
    if (rooms != null) {
      hotelroomimage.value = rooms.roomImages;
    } else {
      hotelroomimage.clear();
    }
  }

  


}

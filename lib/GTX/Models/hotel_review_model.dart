class HotelReviewModel {
  final int hotel;
  final int ratingService;
  final int ratingLocation;
  final int ratingValueForMoney;
  final int ratingCleanliness;
  final String review;

  HotelReviewModel({
    required this.hotel,
    required this.ratingService,
    required this.ratingLocation,
    required this.ratingValueForMoney,
    required this.ratingCleanliness,
    required this.review,
  });

  factory HotelReviewModel.fromJson(Map<String, dynamic> json) {
    return HotelReviewModel(
      hotel: json['hotel'],
      ratingService: json['rating_service'],
      ratingLocation: json['rating_location'],
      ratingValueForMoney: json['rating_value_for_money'],
      ratingCleanliness: json['rating_cleanliness'],
      review: json['review'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hotel': hotel,
      'rating_service': ratingService,
      'rating_location': ratingLocation,
      'rating_value_for_money': ratingValueForMoney,
      'rating_cleanliness': ratingCleanliness,
      'review': review,
    };
  }
}

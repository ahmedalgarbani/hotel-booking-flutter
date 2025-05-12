class RoomReviewModel {
  final int id;
  final int hotel;
  final int roomType;
  final int rating;
  final String review;

  RoomReviewModel({
    required this.id,
    required this.hotel,
    required this.roomType,
    required this.rating,
    required this.review,
  });

  factory RoomReviewModel.fromJson(Map<String, dynamic> json) {
    return RoomReviewModel(
      id: json['id'],
      hotel: json['hotel'],
      roomType: json['room_type'],
      rating: json['rating'],
      review: json['review'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hotel': hotel,
      'room_type': roomType,
      'rating': rating,
      'review': review,
    };
  }
}

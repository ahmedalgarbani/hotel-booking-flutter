class BookingModel {
  final int id;
  final String hotelName;
  final String roomName;
  final String checkInDate;
  final String checkOutDate;
  final double amount;
  final int roomsBooked;

  BookingModel({
    required this.id,
    required this.hotelName,
    required this.roomName,
    required this.checkInDate,
    required this.checkOutDate,
    required this.amount,
    required this.roomsBooked,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? 0,
      hotelName: json['hotel_name'] ?? '',
      roomName: json['room_name'] ?? '',
      checkInDate: json['check_in_date'] ?? '',
      checkOutDate: json['check_out_date'] ?? '',
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      roomsBooked: json['rooms_booked'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hotel_name': hotelName,
      'room_name': roomName,
      'check_in_date': checkInDate,
      'check_out_date': checkOutDate,
      'amount': amount,
      'rooms_booked': roomsBooked,
    };
  }
}

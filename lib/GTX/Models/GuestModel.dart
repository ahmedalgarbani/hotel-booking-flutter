class GuestModel {
  final int? id;
  final String name;
  final String phoneNumber;
  final String? idCardImage; 
  final String gender;
  final String birthdayDate;
  final String checkInDate;
  final String checkOutDate;
  final int hotel;
  final int booking;

  GuestModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    this.idCardImage,
    required this.gender,
    required this.birthdayDate,
    required this.checkInDate,
    required this.checkOutDate,
    required this.hotel,
    required this.booking,
  });

  factory GuestModel.fromJson(Map<String, dynamic> json) {
    return GuestModel(
      id: json['id'],
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      idCardImage: json['id_card_image'],
      gender: json['gender'] ?? '',
      birthdayDate: json['birthday_date'] ?? '',
      checkInDate: json['check_in_date'] ?? '',
      checkOutDate: json['check_out_date'] ?? '',
      hotel: json['hotel'],
      booking: json['booking'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'id_card_image': idCardImage,
      'gender': gender,
      'birthday_date': birthdayDate,
      'check_in_date': checkInDate,
      'check_out_date': checkOutDate,
      'hotel': hotel,
      'booking': booking,
    };
  }
}

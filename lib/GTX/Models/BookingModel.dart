class BookingModel {
  final int id;
  final String hotelName;
  final String roomName;
  final String checkInDate;
  final String checkOutDate;
  final double amount;
  final int roomsBooked;
  final String hotelImage;
  final List<BookingDetail> details;
  final List<GuestModel> guests;

  final String userName;
  final String status;
  BookingModel({
    required this.id,
    required this.hotelName,
    required this.roomName,
    required this.checkInDate,
    required this.checkOutDate,
    required this.amount,
    required this.roomsBooked,
    required this.hotelImage,
    required this.details,
    required this.userName,
    required this.status,
    required this.guests,
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
      hotelImage: json['hotel_image'] ?? '',
      details: (json['details'] as List<dynamic>?)
              ?.map((e) => BookingDetail.fromJson(e))
              .toList() ??
          [],
          guests: (json['guests'] as List<dynamic>?)
          ?.map((e) => GuestModel.fromJson(e))
          .toList() ?? [],

      userName: json['user_name'] ?? '',
      status: json['status']?.toString() ?? '',

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
      'hotel_image': hotelImage,
      'details': details.map((e) => e.toJson()).toList(),
      'guests': guests.map((e) => e.toJson()).toList(),

      'user_name': userName,
      'status': status,

    };
  }
}




class BookingDetail {
  final int id;
  final int booking;
  final int hotel;
  final String hotelName;
  final int service;
  final String serviceName;
  final int quantity;
  final String price;
  final String total;
  final String notes;

  BookingDetail({
    required this.id,
    required this.booking,
    required this.hotel,
    required this.hotelName,
    required this.service,
    required this.serviceName,
    required this.quantity,
    required this.price,
    required this.total,
    required this.notes,
  });

  factory BookingDetail.fromJson(Map<String, dynamic> json) {
    return BookingDetail(
      id: json['id'] ?? 0,
      booking: json['booking'] ?? 0,
      hotel: json['hotel'] ?? 0,
      hotelName: json['hotel_name'] ?? '',
      service: json['service'] ?? 0,
      serviceName: json['service_name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? '',
      total: json['total'] ?? '',
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'booking': booking,
      'hotel': hotel,
      'hotel_name': hotelName,
      'service': service,
      'service_name': serviceName,
      'quantity': quantity,
      'price': price,
      'total': total,
      'notes': notes,
    };
  }
}


class GuestModel {
  final String name;
  final String phoneNumber;
  final String? idCardImage;
  final String gender;
  final String birthdayDate;
  final String checkInDate;
  final String checkOutDate;

  GuestModel({
    required this.name,
    required this.phoneNumber,
    this.idCardImage,
    required this.gender,
    required this.birthdayDate,
    required this.checkInDate,
    required this.checkOutDate,
  });

  factory GuestModel.fromJson(Map<String, dynamic> json) {
    
    return GuestModel(
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      idCardImage: json['id_card_image'],
      gender: json['gender'] ?? '',
      birthdayDate: json['birthday_date'] ?? '',
      checkInDate: json['check_in_date'] ?? '',
      checkOutDate: json['check_out_date'] ?? '',
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
    };
  }
}

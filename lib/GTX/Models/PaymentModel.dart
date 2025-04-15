class PaymentModel {
  final int id;
  final int booking_id;
  final int paymentMethod_id;
  final String paymentSubtotal;

  final String paymentTotalAmount;
  final String paymentCurrency;
  final String paymentType;
  final String transferImage;
  final String paymentNote;
  final String paymentDiscount;
  final int paymentStatus;

  PaymentModel({
    required this.id,
    required this.booking_id,
    required this.paymentMethod_id,
    required this.paymentSubtotal,
    required this.paymentTotalAmount,
    required this.paymentCurrency,
    required this.paymentType,
    required this.transferImage,
    required this.paymentNote,
    required this.paymentDiscount,
    required this.paymentStatus,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
     return PaymentModel(
    id: json['id'] ?? 0,
    booking_id: json['booking_id'] ?? 0,
    paymentMethod_id: json['payment_method_id'] ?? 0,
    paymentSubtotal: json['payment_subtotal'] ?? '0',
    paymentTotalAmount: json['payment_totalamount'] ?? '0',
    paymentCurrency: json['payment_currency'] ?? '',
    paymentType: json['payment_type'] ?? '',
    transferImage: json['transfer_image'] ?? '',
    paymentNote: json['payment_note'] ?? '',
    paymentDiscount: json['payment_discount'] ?? '0',
    paymentStatus: json['payment_status'] ?? 0,
  );
  }
}

class NotificationsModel {
  final int id;
  final String title;
  final String message;
  final String sendTime;
  final bool isRead;
  final String actionUrl;

  NotificationsModel({
    required this.id,
    required this.title,
    required this.message,
    required this.sendTime,
    required this.isRead,
    required this.actionUrl,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      id: json['id'],
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      sendTime: json['send_time'] ?? '',
      isRead: json['status'] == "1",
      actionUrl: json['action_url'] ?? '',
    );
  }
}

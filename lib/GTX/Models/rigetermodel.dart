class Rigetermodel {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String gender;
  final String birth_date;
  final String? password;
  final String? image;

  Rigetermodel({
    required this.gender,
    required this.birth_date,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.password,
    this.image,
  });

  factory Rigetermodel.fromJson(Map<String, dynamic> jsonData) {

    
    String baseUrl = "http://192.168.60.85:8000";
    String logoPath = jsonData['image'] ?? '';

    return Rigetermodel(
      birth_date: jsonData['birth_date'] ?? '',
      gender: jsonData['gender'] ?? '',
      username: jsonData['username'] ?? '',
      email: jsonData['email'] ?? '',
      firstName: jsonData['first_name'] ?? '',
      lastName: jsonData['last_name'] ?? '',
      phone: jsonData['phone'] ?? '',
      password: jsonData['password'],
      image: logoPath.startsWith("http") ? logoPath : baseUrl + logoPath,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'gender': gender,
      'birth_date': birth_date,
      'password': password,
      'image': image,
    };
  }
}

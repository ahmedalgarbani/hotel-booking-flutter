class Rigetermodel {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String? password;  
  final String? image;     

  Rigetermodel({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.password,  
    this.image,     
  });

  factory Rigetermodel.fromJson(Map<String, dynamic> jsonData) {
    return Rigetermodel(
      username: jsonData['username'] ?? '',  
      email: jsonData['email'] ?? '',  
      firstName: jsonData['first_name'] ?? '',
      lastName: jsonData['last_name'] ?? '',
      phone: jsonData['phone'] ?? '',
      password: jsonData['password'],  
      image: jsonData['image'],        
    );
  }
}

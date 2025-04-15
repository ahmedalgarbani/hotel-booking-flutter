class Login {
  final String email;
  final String password;

  Login({
    required this.password,
    required this.email,
  });

  factory Login.fromJson(jsonData) {
    return Login(
      password: jsonData['password'] ?? "",
      email: jsonData['email'] ?? "",
    );
  }
}
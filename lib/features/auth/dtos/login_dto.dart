class LoginDto {
  final String email;
  final String password;

  const LoginDto({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

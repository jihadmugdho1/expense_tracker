class UserModel {
  final String name;
  final String email;
  final String token;
  final bool isLoggedIn;

  UserModel({
    required this.name,
    required this.email,
    required this.token,
    this.isLoggedIn = true,
  });
}

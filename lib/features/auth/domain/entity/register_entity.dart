class RegisterEntity {
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;

  RegisterEntity({
    required this.userName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.confirmPassword,
  });
}

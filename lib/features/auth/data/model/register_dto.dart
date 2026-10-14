import 'package:json_annotation/json_annotation.dart';

part 'register_dto.g.dart';

@JsonSerializable()
class RegisterDto {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterDto({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);
  RegisterDto fromEntity() {
    return RegisterDto(
      name: name,
      phone: phone,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}

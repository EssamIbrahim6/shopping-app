import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/features/auth/domain/entity/login_response_entity.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDto {
  final String? message;
  final String? token;
  final UserDto? user;

  const LoginResponseDto({this.message, this.token, this.user});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDtoToJson(this);
  LoginResponseEntity toEntity() {
    return LoginResponseEntity(
      message: message ?? "",
      token: token ?? "",
      user: user?.toEntity() ?? const AppUserEntity(),
    );
  }
}

@JsonSerializable()
class UserDto {
  final String? name;
  final String? phone;
  final String? email;
  final String? role;
  final String? image;

  const UserDto({this.name, this.phone, this.email, this.role, this.image});

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
  AppUserEntity toEntity() {
    return AppUserEntity(
      name: name ?? "",
      phone: phone ?? "",
      email: email ?? "",
      role: role ?? "",
      image: image ?? "",
    );
  }
}

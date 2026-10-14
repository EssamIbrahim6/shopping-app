// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseDto _$LoginResponseDtoFromJson(Map<String, dynamic> json) =>
    LoginResponseDto(
      message: json['message'] as String?,
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseDtoToJson(LoginResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
      'user': instance.user,
    };

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  role: json['role'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'email': instance.email,
  'role': instance.role,
  'image': instance.image,
};

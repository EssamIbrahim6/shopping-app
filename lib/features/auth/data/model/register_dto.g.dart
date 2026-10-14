// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDto _$RegisterDtoFromJson(Map<String, dynamic> json) => RegisterDto(
  name: json['name'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  confirmPassword: json['confirmPassword'] as String,
);

Map<String, dynamic> _$RegisterDtoToJson(RegisterDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };

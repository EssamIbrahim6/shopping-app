import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String image;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.image,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final map = json.containsKey('message') ? json['message'] : json;
    return _$UserProfileModelFromJson(map);
  }

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}

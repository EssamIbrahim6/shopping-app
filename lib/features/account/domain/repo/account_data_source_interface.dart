import 'package:shopping_app/features/account/data/models/user_profile_model.dart';

abstract class AccountDataSourceInterface {
  Future<UserProfileModel> getUserData();

  Future<void> editUserData({
    required String name,
    required String phone,
    required String address,
    String? imagePath,
  });
}

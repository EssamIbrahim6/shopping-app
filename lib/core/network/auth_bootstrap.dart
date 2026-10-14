import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/core/storage_helper/shared_pref.dart';
import 'package:shopping_app/core/storage_helper/storage_key.dart';

class AuthBootstrap {
  static Future<void> ensureToken() async {
    final savedToken = SharedPref.getString(StorageKey.userToken);
    if ((savedToken == null || savedToken.isEmpty) &&
        ApiConstants.token.isNotEmpty) {
      await SharedPref.saveString(StorageKey.userToken, ApiConstants.token);
    }
  }
}

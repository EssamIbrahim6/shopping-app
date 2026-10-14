import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/storage_helper/storage_key.dart';
import 'package:shopping_app/core/storage_helper/shared_pref.dart';

import 'onboarding_data_source_interface.dart';

@Injectable(as: OnboardingDataSourceInterface)
class OnboardingDataSourceImp implements OnboardingDataSourceInterface {
  @override
  Future<void> saveOnboardingSeen() {
    return SharedPref.saveBool(StorageKey.isOnboardingSeen, true);
  }

  @override
  bool isOnboardingSeen() {
    return SharedPref.getBool(StorageKey.isOnboardingSeen);
  }
}

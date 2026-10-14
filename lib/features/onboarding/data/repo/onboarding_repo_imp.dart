import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/onboarding/data/data_source/onboarding_data_source_interface.dart';
import 'package:shopping_app/features/onboarding/domain/repo/onboarding_repo_interface.dart';

@Injectable(as: OnboardingRepoInterface)
class OnboardingRepoImp implements OnboardingRepoInterface {
  final OnboardingDataSourceInterface onboardingDataSourceInterface;
  OnboardingRepoImp({required this.onboardingDataSourceInterface});

  @override
  Future<void> saveOnboardingSeen() {
    return onboardingDataSourceInterface.saveOnboardingSeen();
  }

  @override
  bool isOnboardingSeen() {
    return onboardingDataSourceInterface.isOnboardingSeen();
  }
}

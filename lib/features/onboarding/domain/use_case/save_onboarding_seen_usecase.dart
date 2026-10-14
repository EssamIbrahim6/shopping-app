import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/onboarding/domain/repo/onboarding_repo_interface.dart';

@injectable
class SaveOnboardingSeenUseCase {
  SaveOnboardingSeenUseCase(this._onboardingRepoInterface);

  final OnboardingRepoInterface _onboardingRepoInterface;

  Future<void> invoke() {
    return _onboardingRepoInterface.saveOnboardingSeen();
  }
}

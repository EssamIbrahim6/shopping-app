import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/onboarding/domain/repo/onboarding_repo_interface.dart';

@injectable
class IsOnboardingSeenUseCase {
  IsOnboardingSeenUseCase(this._onboardingRepoInterface);

  final OnboardingRepoInterface _onboardingRepoInterface;

  bool invoke() {
    return _onboardingRepoInterface.isOnboardingSeen();
  }
}

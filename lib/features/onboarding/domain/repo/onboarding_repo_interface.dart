abstract interface class OnboardingRepoInterface {
  Future<void> saveOnboardingSeen();

  bool isOnboardingSeen();
}

abstract interface class OnboardingDataSourceInterface {
  Future<void> saveOnboardingSeen();

  bool isOnboardingSeen();
}

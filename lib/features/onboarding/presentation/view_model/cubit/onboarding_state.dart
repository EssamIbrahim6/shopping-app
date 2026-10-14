sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingPageChanged extends OnboardingState {
  final int index;
  OnboardingPageChanged(this.index);
}

final class OnboardingSaving extends OnboardingState {
  OnboardingSaving(this.hasVisited);
  final bool hasVisited;
}

final class OnboardingCompleted extends OnboardingState {}

final class OnboardingError extends OnboardingState {
  final String message;

  OnboardingError(this.message);
}

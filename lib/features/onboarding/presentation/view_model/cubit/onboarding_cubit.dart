import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/onboarding/domain/use_case/is_onboarding_seen_usecase.dart';
import 'package:shopping_app/features/onboarding/domain/use_case/save_onboarding_seen_usecase.dart';
import 'package:shopping_app/features/onboarding/presentation/view_model/cubit/onboarding_state.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  final SaveOnboardingSeenUseCase saveOnboardingSeenUseCase;
  final IsOnboardingSeenUseCase isOnboardingSeenUseCase;
  OnboardingCubit(this.saveOnboardingSeenUseCase, this.isOnboardingSeenUseCase)
    : super(OnboardingInitial());
  int currentIndex = 0;

  void _changePage(int index) {
    currentIndex = index;
    emit(OnboardingPageChanged(index));
  }

  void intent(OnboardingIntent intent) async {
    switch (intent) {
      case IntentOnboardingPageChanged():
        _changePage(intent.index);
      case IntentFinishOnboarding():
        await _finishOnboarding();
      case IntentIsOnboardingSeen():
        await _isOnboardingSeen();
    }
  }

  Future<void> _finishOnboarding() async {
    emit(OnboardingSaving(true));
    try {
      await saveOnboardingSeenUseCase.invoke();
      emit(OnboardingCompleted());
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }

  Future<void> _isOnboardingSeen() async {
    // emit(OnboardingSaving(true));
    try {
      var isSeen = isOnboardingSeenUseCase.invoke();
      emit(OnboardingSaving(isSeen));
      // emit(OnboardingCompleted());
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }
}

sealed class OnboardingIntent {}

final class IntentOnboardingPageChanged extends OnboardingIntent {
  final int index;

  IntentOnboardingPageChanged(this.index);
}

final class IntentFinishOnboarding extends OnboardingIntent {}

final class IntentIsOnboardingSeen extends OnboardingIntent {}

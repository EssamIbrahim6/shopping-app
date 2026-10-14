import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/auth/domain/usecase/get_token_usecase.dart';

part 'launcher_state.dart';

@injectable
class LauncherCubit extends Cubit<LauncherState> {
  final GetTokenUseCase _getTokenUseCase;

  LauncherCubit(this._getTokenUseCase) : super(LauncherInitial());

  Future<void> intent(LauncherIntent intent) async {
    switch (intent) {
      case CheckAuthentication():
        final token = await _getTokenUseCase.invoke();

        if (token != null && token.isNotEmpty) {
          emit(LauncherAuthenticated());
        } else {
          emit(LauncherUnauthenticated());
        }
    }
  }
}

sealed class LauncherIntent {}

class CheckAuthentication extends LauncherIntent {}

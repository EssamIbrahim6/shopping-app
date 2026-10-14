import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/domain/entity/login_response_entity.dart';
import 'package:shopping_app/features/auth/domain/usecase/login_usecase.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _loginUsecase;
  LoginCubit(this._loginUsecase) : super(LoginInitial());
  Future<void> intent(LoginIntent intent) async {
    switch (intent) {
      case LoginIntentLogin():
        _login(email: intent.email, password: intent.password);
    }
  }

  void _login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await _loginUsecase.invoke(email: email, password: password);
    switch (result) {
      case Success():
        emit(LoginSuccess(result.data));

      case Error():
        emit(LoginError(result.messageError));
    }
  }
}

sealed class LoginIntent {}

class LoginIntentLogin extends LoginIntent {
  LoginIntentLogin({required this.email, required this.password});
  String email;
  final String password;
}

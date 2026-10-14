import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/domain/entity/register_entity.dart';

import 'package:shopping_app/features/auth/domain/usecase/register_usecase.dart';
part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;
  RegisterCubit(this._registerUseCase) : super(RegisterInitial());
  Future<void> intent(RegisterIntent intent) async {
    switch (intent) {
      case RegisterIntentImpl():
        _register(intent.request);
    }
  }

  Future<void> _register(RegisterEntity request) async {
    final result = await _registerUseCase.invoke(request);
    switch (result) {
      case Success():
        emit(RegisterSuccess());

      case Error():
        emit(RegisterFailure(message: result.messageError));
    }
  }
}

sealed class RegisterIntent {}

class RegisterIntentImpl implements RegisterIntent {
  final RegisterEntity request;
  RegisterIntentImpl({required this.request});
}

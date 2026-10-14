import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/hello/domain/usecases/has_visited_hello_use_case.dart';
import 'package:shopping_app/features/hello/domain/usecases/mark_hello_as_visited_use_case.dart';
import 'package:shopping_app/features/hello/presentation/view_model/hello_intent.dart';

part 'hello_state.dart';

@injectable
class HelloCubit extends Cubit<HelloState> {
  HelloCubit(this._hasVisitedHelloUseCase, this._markHelloAsVisitedUseCase)
    : super(HelloInitial());

  final HasVisitedHelloUseCase _hasVisitedHelloUseCase;
  final MarkHelloAsVisitedUseCase _markHelloAsVisitedUseCase;

  Future<void> intent(HelloIntent intent) async {
    switch (intent) {
      case HasVisitedHello():
        _hasVisitedHello();

      case MarkHelloAsVisited():
        await _markHelloAsVisited();
    }
  }

  Future<void> _markHelloAsVisited() async {
    emit(HelloLoading());
    await _markHelloAsVisitedUseCase.invoke();
    emit(HelloMarkedAsVisited());
  }

  void _hasVisitedHello() {
    final hasVisited = _hasVisitedHelloUseCase.invoke();
    emit(HelloVisited(hasVisited));
  }
}

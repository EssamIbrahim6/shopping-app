import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/domain/use_case/get_categories_usecase.dart';

part 'categories_intent.dart';

@injectable
class CategoriesCubit extends Cubit<BaseState<List<CategoryEntity>>> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  CategoriesCubit(this._getCategoriesUseCase) : super(const BaseInitialState());

  Future<void> intent(CategoriesIntent intent) async {
    switch (intent) {
      case FetchCategories():
        await _fetchCategories();
    }
  }

  Future<void> _fetchCategories() async {
    // emit(BaseFailureState(errorMessage: 'Oops! No categories found right now. Check back soon for exciting updates!'));

    emit(const BaseLoadingState());
    var result = await _getCategoriesUseCase.invoke();
    switch (result) {
      case Success<List<CategoryEntity>>():
        emit(BaseSuccessState(data: result.data));
      case Error<List<CategoryEntity>>():
        emit(BaseFailureState(errorMessage: result.messageError));
    }
  }
}

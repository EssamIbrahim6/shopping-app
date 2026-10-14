import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/use_case/get_product_by_id_usecase.dart';

part 'product_details_intent.dart';
part 'product_details_state.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this._getProductByIdUseCase)
    : super(ProductDetailsInitial());

  final GetProductByIdUseCase _getProductByIdUseCase;

  Future<void> intent(ProductDetailsIntent intent) async {
    switch (intent) {
      case FetchProductDetails():
        await _fetchProduct(intent.productId);
    }
  }

  Future<void> _fetchProduct(int productId) async {
    emit(ProductDetailsLoading());

    final result = await _getProductByIdUseCase.invoke(productId: productId);

    switch (result) {
      case Success<ProductItemEntity>():
        emit(ProductDetailsSuccess(result.data));
      case Error<ProductItemEntity>():
        emit(ProductDetailsFailure(result.messageError));
    }
  }
}

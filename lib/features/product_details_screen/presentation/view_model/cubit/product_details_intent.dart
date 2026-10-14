part of 'product_details_cubit.dart';

sealed class ProductDetailsIntent extends Equatable {
  const ProductDetailsIntent();

  @override
  List<Object?> get props => [];
}

class FetchProductDetails extends ProductDetailsIntent {
  final int productId;

  const FetchProductDetails(this.productId);

  @override
  List<Object?> get props => [productId];
}

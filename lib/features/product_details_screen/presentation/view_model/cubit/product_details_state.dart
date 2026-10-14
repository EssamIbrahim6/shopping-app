part of 'product_details_cubit.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object?> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsSuccess extends ProductDetailsState {
  final ProductItemEntity product;

  const ProductDetailsSuccess(this.product);

  @override
  List<Object?> get props => [product];
}

final class ProductDetailsFailure extends ProductDetailsState {
  final String errorMessage;

  const ProductDetailsFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

part of 'product_slider_cubit.dart';

class ProductSliderState extends Equatable {
  final int currentIndex;
  final bool isFavorite;

  const ProductSliderState({this.currentIndex = 0, this.isFavorite = false});

  ProductSliderState copyWith({int? currentIndex, bool? isFavorite}) {
    return ProductSliderState(
      currentIndex: currentIndex ?? this.currentIndex,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [currentIndex, isFavorite];
}

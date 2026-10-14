import 'package:json_annotation/json_annotation.dart';

part 'search_products_by_category_request_body.g.dart';

@JsonSerializable()
class SearchProductsByCategoryRequestBody {
  const SearchProductsByCategoryRequestBody({
    this.search = '',
    this.skip = 0,
    this.limit = 10,
  });

  factory SearchProductsByCategoryRequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$SearchProductsByCategoryRequestBodyFromJson(json);

  final String search;
  final int skip;
  final int limit;

  Map<String, dynamic> toJson() =>
      _$SearchProductsByCategoryRequestBodyToJson(this);

  SearchProductsByCategoryRequestBody copyWith({
    String? search,
    int? skip,
    int? limit,
  }) {
    return SearchProductsByCategoryRequestBody(
      search: search ?? this.search,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }
}

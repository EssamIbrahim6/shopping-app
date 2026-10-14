// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_products_by_category_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchProductsByCategoryRequestBody
_$SearchProductsByCategoryRequestBodyFromJson(Map<String, dynamic> json) =>
    SearchProductsByCategoryRequestBody(
      search: json['search'] as String? ?? '',
      skip: (json['skip'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$SearchProductsByCategoryRequestBodyToJson(
  SearchProductsByCategoryRequestBody instance,
) => <String, dynamic>{
  'search': instance.search,
  'skip': instance.skip,
  'limit': instance.limit,
};

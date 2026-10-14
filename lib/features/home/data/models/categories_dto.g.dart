// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesDto _$CategoriesDtoFromJson(Map<String, dynamic> json) =>
    CategoriesDto(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriesDtoToJson(CategoriesDto instance) =>
    <String, dynamic>{'list': instance.list};

CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) => CategoryDto(
  slug: json['slug'] as String?,
  name: json['name'] as String?,
  url: json['url'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$CategoryDtoToJson(CategoryDto instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'name': instance.name,
      'url': instance.url,
      'image': instance.image,
    };

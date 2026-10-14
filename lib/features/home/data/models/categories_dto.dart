import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';

part 'categories_dto.g.dart';

@JsonSerializable()
class CategoriesDto {
  const CategoriesDto({this.list});

  final List<CategoryDto>? list;

  factory CategoriesDto.fromJson(Map<String, dynamic> json) =>
      _$CategoriesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesDtoToJson(this);
}

@JsonSerializable()
class CategoryDto {
  const CategoryDto({this.slug, this.name, this.url, this.image});

  final String? slug;
  final String? name;
  final String? url;
  final String? image;

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  CategoryEntity toEntity() {
    return CategoryEntity(name: name ?? '', slug: slug ?? '');
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  final String? itemId;
  final String? title;
  final String? description;
  final double? price;
  final List<String?>? images;
  final String? category;
  final String? subCategory;
  final DateTime? dateAdded;
  final DateTime? dateModified;
  final bool? inStock;

  Item({
    this.images,
    this.itemId,
    this.title,
    this.description,
    this.price,
    this.category,
    this.subCategory,
    this.dateAdded,
    this.dateModified,
    this.inStock,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
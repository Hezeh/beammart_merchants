import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  String? itemId;
  String? title;
  String? description;
  double? price;
  List<String?>? images;
  String? category;
  String? subCategory;
  DateTime? dateAdded;
  DateTime? dateModified;
  bool? inStock;
  String? lastRenewal;
  bool? isActive;

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
    this.lastRenewal,
    this.isActive,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

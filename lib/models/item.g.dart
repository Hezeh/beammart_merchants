// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
    itemId: json['itemId'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    price: (json['price'] as num)?.toDouble(),
    category: json['category'] as String,
    subCategory: json['subCategory'] as String,
    dateAdded: json['dateAdded'] == null
        ? null
        : DateTime.parse(json['dateAdded'] as String),
    dateModified: json['dateModified'] == null
        ? null
        : DateTime.parse(json['dateModified'] as String),
    inStock: json['inStock'] as bool,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'itemId': instance.itemId,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'images': instance.images,
      'category': instance.category,
      'subCategory': instance.subCategory,
      'dateAdded': instance.dateAdded?.toIso8601String(),
      'dateModified': instance.dateModified?.toIso8601String(),
      'inStock': instance.inStock,
    };

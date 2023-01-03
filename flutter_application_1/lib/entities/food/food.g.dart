// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      linkImg: json['linkImg'] as String,
      desc: json['desc'] as String? ?? "Lorem ipsum dolor sit amet",
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'price': instance.price,
      'desc': instance.desc,
      'linkImg': instance.linkImg,
    };

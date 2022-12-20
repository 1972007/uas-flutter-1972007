// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MovieHistory _$$_MovieHistoryFromJson(Map<String, dynamic> json) =>
    _$_MovieHistory(
      time_bought: parseTimestamp(json['time_bought'] as Timestamp),
      price: BigInt.parse(json['price'] as String),
      time_watch: parseTimestamp(json['time_watch'] as Timestamp),
      movie_id: json['movie_id'] as int,
    );

Map<String, dynamic> _$$_MovieHistoryToJson(_$_MovieHistory instance) =>
    <String, dynamic>{
      'time_bought': instance.time_bought.toIso8601String(),
      'price': instance.price.toString(),
      'time_watch': instance.time_watch.toIso8601String(),
      'movie_id': instance.movie_id,
    };

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:io';
part "movie_history.freezed.dart";
part "movie_history.g.dart";
@freezed
class MovieHistory with _$MovieHistory{
  const factory MovieHistory({
    @JsonKey(name:"time_bought", fromJson: parseTimestamp ) required DateTime time_bought,
    required BigInt price,
    @JsonKey(name:"time_watch", fromJson: parseTimestamp ) required DateTime time_watch,
    required int movie_id
  }) = _MovieHistory;
  factory MovieHistory.fromJson(Map<String, dynamic> json) => _$MovieHistoryFromJson(json);
}
DateTime parseTimestamp(Timestamp timestamp) => timestamp.toDate();
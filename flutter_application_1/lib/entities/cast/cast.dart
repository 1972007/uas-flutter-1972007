
import 'package:freezed_annotation/freezed_annotation.dart';
part "cast.freezed.dart";
part "cast.g.dart";
@freezed
class Cast with _$Cast{
  const factory Cast({
      bool? adult,
      int? gender,
      int? id,
      String? known_for_department,
      String? name,
      String? original_name,
      double? popularity,
      String? profile_path,
      int? cast_id,
      String? character,
      String? credit_id,
      int? order,
  }) = _Cast;
  factory Cast.fromJson(Map<String,dynamic> json) => _$CastFromJson(json);
}
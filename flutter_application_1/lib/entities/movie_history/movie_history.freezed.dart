// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'movie_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MovieHistory _$MovieHistoryFromJson(Map<String, dynamic> json) {
  return _MovieHistory.fromJson(json);
}

/// @nodoc
mixin _$MovieHistory {
  @JsonKey(name: "time_bought", fromJson: parseTimestamp)
  DateTime get time_bought => throw _privateConstructorUsedError;
  BigInt get price => throw _privateConstructorUsedError;
  @JsonKey(name: "time_watch", fromJson: parseTimestamp)
  DateTime get time_watch => throw _privateConstructorUsedError;
  int get movie_id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovieHistoryCopyWith<MovieHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieHistoryCopyWith<$Res> {
  factory $MovieHistoryCopyWith(
          MovieHistory value, $Res Function(MovieHistory) then) =
      _$MovieHistoryCopyWithImpl<$Res, MovieHistory>;
  @useResult
  $Res call(
      {@JsonKey(name: "time_bought", fromJson: parseTimestamp)
          DateTime time_bought,
      BigInt price,
      @JsonKey(name: "time_watch", fromJson: parseTimestamp)
          DateTime time_watch,
      int movie_id});
}

/// @nodoc
class _$MovieHistoryCopyWithImpl<$Res, $Val extends MovieHistory>
    implements $MovieHistoryCopyWith<$Res> {
  _$MovieHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time_bought = null,
    Object? price = null,
    Object? time_watch = null,
    Object? movie_id = null,
  }) {
    return _then(_value.copyWith(
      time_bought: null == time_bought
          ? _value.time_bought
          : time_bought // ignore: cast_nullable_to_non_nullable
              as DateTime,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as BigInt,
      time_watch: null == time_watch
          ? _value.time_watch
          : time_watch // ignore: cast_nullable_to_non_nullable
              as DateTime,
      movie_id: null == movie_id
          ? _value.movie_id
          : movie_id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MovieHistoryCopyWith<$Res>
    implements $MovieHistoryCopyWith<$Res> {
  factory _$$_MovieHistoryCopyWith(
          _$_MovieHistory value, $Res Function(_$_MovieHistory) then) =
      __$$_MovieHistoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "time_bought", fromJson: parseTimestamp)
          DateTime time_bought,
      BigInt price,
      @JsonKey(name: "time_watch", fromJson: parseTimestamp)
          DateTime time_watch,
      int movie_id});
}

/// @nodoc
class __$$_MovieHistoryCopyWithImpl<$Res>
    extends _$MovieHistoryCopyWithImpl<$Res, _$_MovieHistory>
    implements _$$_MovieHistoryCopyWith<$Res> {
  __$$_MovieHistoryCopyWithImpl(
      _$_MovieHistory _value, $Res Function(_$_MovieHistory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time_bought = null,
    Object? price = null,
    Object? time_watch = null,
    Object? movie_id = null,
  }) {
    return _then(_$_MovieHistory(
      time_bought: null == time_bought
          ? _value.time_bought
          : time_bought // ignore: cast_nullable_to_non_nullable
              as DateTime,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as BigInt,
      time_watch: null == time_watch
          ? _value.time_watch
          : time_watch // ignore: cast_nullable_to_non_nullable
              as DateTime,
      movie_id: null == movie_id
          ? _value.movie_id
          : movie_id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MovieHistory implements _MovieHistory {
  const _$_MovieHistory(
      {@JsonKey(name: "time_bought", fromJson: parseTimestamp)
          required this.time_bought,
      required this.price,
      @JsonKey(name: "time_watch", fromJson: parseTimestamp)
          required this.time_watch,
      required this.movie_id});

  factory _$_MovieHistory.fromJson(Map<String, dynamic> json) =>
      _$$_MovieHistoryFromJson(json);

  @override
  @JsonKey(name: "time_bought", fromJson: parseTimestamp)
  final DateTime time_bought;
  @override
  final BigInt price;
  @override
  @JsonKey(name: "time_watch", fromJson: parseTimestamp)
  final DateTime time_watch;
  @override
  final int movie_id;

  @override
  String toString() {
    return 'MovieHistory(time_bought: $time_bought, price: $price, time_watch: $time_watch, movie_id: $movie_id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MovieHistory &&
            (identical(other.time_bought, time_bought) ||
                other.time_bought == time_bought) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.time_watch, time_watch) ||
                other.time_watch == time_watch) &&
            (identical(other.movie_id, movie_id) ||
                other.movie_id == movie_id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, time_bought, price, time_watch, movie_id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MovieHistoryCopyWith<_$_MovieHistory> get copyWith =>
      __$$_MovieHistoryCopyWithImpl<_$_MovieHistory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MovieHistoryToJson(
      this,
    );
  }
}

abstract class _MovieHistory implements MovieHistory {
  const factory _MovieHistory(
      {@JsonKey(name: "time_bought", fromJson: parseTimestamp)
          required final DateTime time_bought,
      required final BigInt price,
      @JsonKey(name: "time_watch", fromJson: parseTimestamp)
          required final DateTime time_watch,
      required final int movie_id}) = _$_MovieHistory;

  factory _MovieHistory.fromJson(Map<String, dynamic> json) =
      _$_MovieHistory.fromJson;

  @override
  @JsonKey(name: "time_bought", fromJson: parseTimestamp)
  DateTime get time_bought;
  @override
  BigInt get price;
  @override
  @JsonKey(name: "time_watch", fromJson: parseTimestamp)
  DateTime get time_watch;
  @override
  int get movie_id;
  @override
  @JsonKey(ignore: true)
  _$$_MovieHistoryCopyWith<_$_MovieHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

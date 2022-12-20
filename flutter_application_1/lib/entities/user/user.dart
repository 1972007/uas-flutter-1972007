import "package:flutter/material.dart";
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';
@immutable
@freezed
class User with _$User{
  const factory User({
    required String user,
    required String name}
  )= _User;

  factory User.fromJson(Map<String, dynamic> json)=> _$UserFromJson(json);
}
import 'package:freezed_annotation/freezed_annotation.dart';
part "movie.freezed.dart";
part "movie.g.dart";

@freezed
class Movie with _$Movie{
  const factory Movie(
    {required bool adult, 
    String?backdrop_path, 
    required List<int> genre_ids, 
    required int id, 
    required String original_language, 
    required String original_title, 
    required String overview, 
    required double popularity, 
    required String poster_path, 
    required String release_date, 
    required String title, 
    required bool video, 
    required double vote_average, 
    required int vote_count, }
  ) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
import 'package:freezed_annotation/freezed_annotation.dart';
part "movie_detail.freezed.dart";
part "movie_detail.g.dart";

@freezed
class MovieDetail with _$MovieDetail{
  const factory MovieDetail(
    {
    required bool adult,
    required String backdrop_path,
    required dynamic belongs_to_collection,
    required int budget,
    required List genres,
    required  String homepage,
    required int id,
    required  String imdb_id,
    required  String original_language,
    required  String original_title,
    required  String overview,
    required double popularity,
    required String poster_path,
    required List<dynamic> production_companies,
    required List<dynamic> production_countries,
    required String release_date,
    required int revenue,
    required int runtime,
    required List<dynamic> spoken_languages,
    required String status,
    required String tagline,
    required String title,
    required bool video,
    required double vote_average,
    required int vote_count,

    }
  ) = _MovieDetail;

  factory MovieDetail.fromJson(Map<String, dynamic> json) => _$MovieDetailFromJson(json);

}
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/entities/cast/cast.dart';
import 'package:flutter_application_1/entities/genre/genre.dart';
import 'package:flutter_application_1/entities/movie/movie.dart';
import 'package:flutter_application_1/entities/movie_detail/movie_detail.dart';
import 'package:flutter_application_1/entities/tresult/tresult.dart';
//https://api.themoviedb.org/3/movie/11/credits?api_key=dcc8a60da01e2ee395123d3f9fbd5887&language=en-US
class MovieServices{
  Dio dio = Dio();
  final String _api_key = "dcc8a60da01e2ee395123d3f9fbd5887";
  Future<TResult<List<Movie>?>> getPopularMovies({int page=1}) async{
    try{
      var res = await dio.get("https://api.themoviedb.org/3/movie/popular?api_key=$_api_key&language=en-US&page=1");
      // for(var sth in res.data["results"][0].keys.toList()){
      //   print("required ${res.data["results"][0]["$sth"].runtimeType} ${sth}, ");
      // };

      return TResult.success((res.data["results"] as List).map((e) => Movie.fromJson(e)).toList());
    } on DioError catch (e){
      log(e.response.toString());
      return TResult.failed(e.response.toString());
    }
  }

  Future<TResult<MovieDetail>?> getMovieDetail(int id) async{
    try{
      var res = await dio.get("https://api.themoviedb.org/3/movie/$id?api_key=$_api_key");
      // for(var sth in res.data["results"][0].keys.toList()){
      //   print("required ${res.data["results"][0]["$sth"].runtimeType} ${sth}, ");
      // };

      return TResult.success(MovieDetail.fromJson(res.data));
    } on DioError catch (e){
      log(e.response.toString());
      return TResult.failed(e.response.toString());
    }
  }

  Future<TResult<List<Genre>?>> getGenres() async{
    try{
      var res = await dio.get("https://api.themoviedb.org/3/genre/movie/list?api_key=$_api_key");
      
      return TResult.success((res.data["genres"] as List).map((e) => Genre.fromJson(e)).toList());  
    }on DioError catch (e){
      log(e.response.toString());
      return TResult.failed(e.response.toString());
    } 
  }

  String linkImg(String path){
    return "https://image.tmdb.org/t/p/original$path";
  }

  Future<TResult<String>> movieIdToLinkImg(int movie_id) async{
    try{
      var res = await dio.get("https://api.themoviedb.org/3/movie/$movie_id/images?api_key=$_api_key&language=en-US");
      return TResult.success(res.data.toString());
    }
    on DioError catch(e){
      log(e.response.toString());
      return TResult.failed(e.response.toString());}
  }

  Future<TResult<List<Cast>?>> getMovieCast(int movie_id) async {
    try{
      var res = await dio.get("https://api.themoviedb.org/3/movie/$movie_id/credits?api_key=$_api_key&language=en-US");
      //log(res.data["cast"].toString());
      return TResult.success((res.data["cast"] as List).map((e) => Cast.fromJson(e)).toList());
    }on DioError catch(e){
      log(e.response.toString());
      return TResult.failed(e.response.toString());
    }
  }

  Future<TResult<List<Movie>?>> getUpcomingMovie({int page=1}) async{
    try{
      var res = await dio.get("https://api.themoviedb.org/3/movie/upcoming?api_key=$_api_key&language=en-US&page=$page");
      // for(var sth in res.data["results"][0].keys.toList()){
      //   print("required ${res.data["results"][0]["$sth"].runtimeType} ${sth}, ");
      // };

      return TResult.success((res.data["results"] as List).map((e) => Movie.fromJson(e)).toList());
    } on DioError catch (e){
      log(e.response.toString());
      return TResult.failed(e.response.toString());
    }

  }
}
import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/entities/genre/genre.dart';
import 'package:flutter_application_1/entities/movie/movie.dart';
import 'package:flutter_application_1/entities/movie_detail/movie_detail.dart';
import 'package:flutter_application_1/entities/tresult/tresult.dart';
import 'package:flutter_application_1/services/movie_service.dart';

void main(List<String> args) async {
  // Dio dio=new Dio();
  
  // const String _api_key = "dcc8a60da01e2ee395123d3f9fbd5887";
  // var res = await dio.get("https://api.themoviedb.org/3/movie/11?api_key=$_api_key&language=en-US");
  // print(res);
  MovieServices services = MovieServices();
  TResult? res = await services.movieIdToLinkImg(11);
  if(res!=null){
    print(res.toString());
  }
  // TResult<MovieDetail>? result = await services.getMovieDetail(11);
  // print(result!.when(success: ((value) => value.toString()), failed:((message) => message)));
  // // List<Movie>? list = result.when(success: ((value) => value), failed: ((message) => null));
  // if(list!= null){
  //   print(list[1]);
  //   for (var element in list) {print(element); }
  // }
  // TResult tResult2 = await services.getGenres();
  // List<Genre>? list2 = tResult2.when(success: ((value) => value), failed: ((message) => null));
  // if(list2!=null){
  //   for (var element in list2) {print(element);}
  // }
}
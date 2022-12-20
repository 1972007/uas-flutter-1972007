import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/movie/movie.dart';
import 'package:flutter_application_1/entities/tresult/tresult.dart';
import 'package:flutter_application_1/services/movie_service.dart';
import 'package:flutter_application_1/widget/genre_icon.dart';
import 'package:flutter_application_1/widget/movie_poster.dart';
import 'package:go_router/go_router.dart';

class MovieChoicePage extends StatelessWidget{
  MovieServices services = MovieServices();
  List<Movie>? movies;
  MovieChoicePage({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: services.getPopularMovies(),
      builder: ((context, snapshot) => Scaffold(
          backgroundColor: const Color.fromARGB(255, 4, 28, 69),
          body:  Column(
              children: [
                const SizedBox(height: 20,),
                const Text("Popular Movies", textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Center(
                  child: SizedBox(
                    height: 210,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) => 
                        MoviePoster(link:services.linkImg(snapshot.data!.when(
                              success: ((value) => value![index].poster_path), 
                              failed: ((message) => "https://image.tmdb.org/t/p/original//pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg"),
                            ),
                          ), id:  snapshot.hasData ? snapshot.data!.when(success: ((value) => value![index].id), failed: ((message) => 0)) : 0 
                        )
                      ), 
                      separatorBuilder: ((context, index) => const SizedBox(width: 3,height: 3,)), 
                      itemCount: snapshot.hasData ? 
                        snapshot.data!.when(
                          success:((value) => value!.length), 
                          failed: ((message) => 0)) 
                        : 0
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                
              ],
            ),
          
      )
    ));
  }
}
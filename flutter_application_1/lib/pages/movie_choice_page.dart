import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/movie/movie.dart';
import 'package:flutter_application_1/entities/tresult/tresult.dart';
import 'package:flutter_application_1/services/movie_service.dart';
import 'package:flutter_application_1/widget/genre_icon.dart';
import 'package:flutter_application_1/widget/movie_poster.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieChoicePage extends StatelessWidget{
  MovieServices services = MovieServices();
  List<Movie>? movies;
  MovieChoicePage({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var poppins = GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold);
    return FutureBuilder(
      future: Future.wait([services.getPopularMovies(),services.getUpcomingMovie()]),
      builder: ((context, snapshot) => ListView(
        
              children: [
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: Text("Popular Movies", textAlign: TextAlign.left, style: poppins,),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: SizedBox(
                    height: 210,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) => 
                        MoviePoster(
                          link:services.linkImg(
                            snapshot.data![0].when(
                              success: ((value) => value![index].poster_path), 
                              failed: ((message) => "https://image.tmdb.org/t/p/original//pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg"),
                            ),
                          ), id:  snapshot.hasData ? snapshot.data![0].when(success: ((value) => value![index].id), failed: ((message) => 0)) : 0 
                        )
                      ), 
                      separatorBuilder: ((context, index) => const SizedBox(width: 3,height: 3,)), 
                      itemCount: snapshot.hasData ? 
                        snapshot.data![0].when(
                          success:((value) => value!.length), 
                          failed: ((message) => 0)) 
                        : 0
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child:Text("Upcoming Movies", textAlign: TextAlign.left, style: poppins)
                ),
                const SizedBox(height: 20,),
                Center(
                  child: SizedBox(
                    height: 210,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) => 
                        MoviePoster(
                          isUpcoming: true,
                          link:services.linkImg(
                            snapshot.data![1].when(
                              success: ((value) => value![index].poster_path), 
                              failed: ((message) => "https://image.tmdb.org/t/p/original//pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg"),
                              ),
                            ), 
                          id:  snapshot.hasData ? snapshot.data![1].when(success: ((value) => value![index].id), failed: ((message) => 0)) : 0
                          
                        )
                      ), 
                      separatorBuilder: ((context, index) => const SizedBox(width: 3,height: 3,)), 
                      itemCount: snapshot.hasData ? 
                        snapshot.data![1].when(
                          success:((value) => value!.length), 
                          failed: ((message) => 0)) 
                        : 0
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                
              ],
            )
          
      )
    );
  }
}
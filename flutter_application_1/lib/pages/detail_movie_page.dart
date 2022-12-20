import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/tresult/tresult.dart';
import 'package:flutter_application_1/services/movie_service.dart';
import 'package:go_router/go_router.dart';

class MovieDetailPage extends StatelessWidget{
  int movie_id;
  MovieServices services = MovieServices();
  MovieDetailPage({super.key, required this.movie_id});

  @override
  Widget build(BuildContext context) { 
    
    return FutureBuilder(
      future:  services.getMovieDetail(movie_id),
      builder: (context, snapshot) =>  Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 0, 20, 50),
            leading: IconButton(
                onPressed: () {
                  context.go("/main");
                },
                icon: const Icon(Icons.arrow_back)),
          ),
        backgroundColor: const Color.fromARGB(255, 4, 28, 69),
        body: Column(
            children: [
              const SizedBox(height: 20,),
              Center(
                child: Container(
                  width: 240,
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage( snapshot.hasData ?
                        snapshot.data!.when(
                          success: ((value) => services.linkImg(value.poster_path)), 
                          failed: ((message) => "https://image.tmdb.org/t/p/original//pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg")
                        ) : "https://image.tmdb.org/t/p/original//pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg"
                      )
                    )
                  ), 
                ),
              ),
              const SizedBox(height: 20,),
              Text(snapshot.hasData ?
                        snapshot.data!.when(
                          success: ((value) => value.title), 
                          failed: ((message) => "Movie")) : "Movie", 
                    textAlign: TextAlign.left, 
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(snapshot.hasData ?
                          snapshot.data!.when(
                            success: ((value) => value.overview), 
                            failed: ((message) => "It is a Movie")) : "It is a Movie", 
                      textAlign: TextAlign.center, 
                      style: const TextStyle(color: Colors.white),),
              ),
            ],
          ),
      ),
        
      )
    ;
  }
}
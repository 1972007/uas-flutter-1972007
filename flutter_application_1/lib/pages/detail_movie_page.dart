import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/cast/cast.dart';
import 'package:flutter_application_1/entities/movie_detail/movie_detail.dart';
import 'package:flutter_application_1/entities/tresult/tresult.dart';
import 'package:flutter_application_1/services/movie_service.dart';
import 'package:flutter_application_1/widget/cast_poster.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetailPage extends StatelessWidget{
  int movie_id;
  bool isUpcoming;
  MovieServices services = MovieServices();
  MovieDetailPage({super.key, required this.movie_id, this.isUpcoming = false});

  @override
  Widget build(BuildContext context) {
    int itemCount = 1;
    var poppins = GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold);
    return FutureBuilder(
      future:  Future.wait([services.getMovieDetail(movie_id),services.getMovieCast(movie_id)]),
      builder: (context, snapshot) =>  Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 0, 20, 50),
            leading: IconButton(
                onPressed: () {
                  context.go("/main");
                },
                icon: const Icon(Icons.arrow_back)
            ),
          ),
        backgroundColor: const Color.fromARGB(255, 4, 28, 69),
        body: ListView(
            children: [
              const SizedBox(height: 20,),
              Center(
                child: Container(
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage( snapshot.hasData &&  snapshot.data![0] !=null?
                        snapshot.data![0]!.when(
                          success: ((value) => services.linkImg((value as MovieDetail).poster_path)), 
                          failed: ((message) => "https://image.tmdb.org/t/p/original//pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg")
                        ) : "https://image.tmdb.org/t/p/original//pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg"
                      )
                    )
                  ), 
                ),
              ),
              const SizedBox(height: 20,),
              
              //Button Buy
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: isUpcoming == false ?
                  ElevatedButton(
                    
                    onPressed: (() { 
                        context.pushNamed("buy", queryParams: 
                          {"movie_id": movie_id.toString(), 
                          "title":snapshot.hasData &&  snapshot.data![0] !=null?
                            snapshot.data![0]!.when(success: (value) => (value as MovieDetail).title,failed: (message) => "Movie",) : "Movie"});
                    } ), 
                    child: Text("Buy Ticket",style: GoogleFonts.poppins(color: Colors.white)) 
                  ):
                  ElevatedButton(
                    onPressed: null, 
                    child:  Text("Ticket Unavailable",style: poppins)  
                  ) ,
              ),
              
              const SizedBox(height: 20,),
              
              Text(snapshot.hasData &&  snapshot.data![0] !=null?
                        snapshot.data![0]!.when(
                          success: ((value) => (value as MovieDetail).title), 
                          failed: ((message) => "Movie")) : "Movie", 
                    textAlign: TextAlign.center, 
                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(snapshot.hasData &&  snapshot.data![0] !=null?
                        snapshot.data![0]!.when(
                            success: ((value) => (value as MovieDetail).overview), 
                            failed: ((message) => "It is a Movie")) : "It is a Movie", 
                      textAlign: TextAlign.center, 
                      style: GoogleFonts.poppins(color: Colors.white),),
              ),
              Text("Cast", 
                textAlign: TextAlign.center, 
                style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              SizedBox(
                height: 270,
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: 
                        snapshot.hasData && snapshot.data![1] != null ? snapshot.data![1]!.when(
                          success: ((value) {
                            
                              // Container(
                              //   width: 140,
                              //   height: 210,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(5),
                              //     color: Colors.white,
                              //     image: 
                              //       DecorationImage(image: NetworkImage(services.linkImg( e.profile_path ?? 
                              //        "https://image.tmdb.org/t/p/original//pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg")))
                              //   ),
                              //   child: Text(e.name?? "Cast")
                              // )
                            List<Widget> widgets = (value as List<Cast>).map((e) => 
                              CastPoster(
                                img_path: services.linkImg( e.profile_path ?? 
                                      "https://image.tmdb.org/t/p/original//pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg"), 
                                cast_name: e.name?? "Cast")
                            ).toList();
                            itemCount = widgets.length;
                            return widgets;
                          }), 
                          failed: ((message) => [Container(
                          width: 140,
                          height: 210,
                          
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            image: const DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/original//pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg"))
                          ),
                          child:  Text( "Cast", style: GoogleFonts.poppins(),) 
                        )])) :
                        [Container(
                          width: 140,
                          height: 210,
                          
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            image: const DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/original//pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg"))
                          ),
                          child: Text( "Cast", style: GoogleFonts.poppins(),) 
                        )]          
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount:itemCount, 
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 15,height: 15,);
                  },
                ),
              ),
            ],
          ),
      ),
        
      )
    ;
  }
}
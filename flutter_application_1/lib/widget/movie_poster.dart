import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviePoster extends StatelessWidget{
  String link;
  int id;
  bool isUpcoming;
  MoviePoster({super.key, required this.link, required this.id, this.isUpcoming=false});

  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        context.pushNamed("detail", queryParams: {
          "movie_id":id.toString(),
          "isUpcoming":isUpcoming.toString()
        });
      },
      child: Container(
        width: 140,
        height: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          image: DecorationImage(image: NetworkImage(link))
        ), 
      ),
    );
                    
  }


}
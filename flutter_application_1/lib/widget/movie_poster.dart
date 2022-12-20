import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviePoster extends StatelessWidget{
  String link;
  int id;
  MoviePoster({super.key, required this.link, required this.id});

  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        context.pushNamed("detail", extra: id);
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
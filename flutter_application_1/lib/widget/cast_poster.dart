import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CastPoster extends StatelessWidget{
  String img_path;
  String cast_name;
  CastPoster({super.key, required this.img_path, required this.cast_name});
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 140,
            height: 210,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(img_path)),)),
        const SizedBox(width: 10,height: 10,),        
        Text(cast_name, textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.white, fontWeight:FontWeight.bold ),)
      ],
    );
    }
 
  }
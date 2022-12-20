import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GenreIcon extends StatelessWidget{
  Widget icon;
  String name;
  GenreIcon({super.key, required this.icon, required this.name});

  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Column(children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                  offset: Offset(2, 2),
                  color: Colors.black26,
                  blurRadius: 2,
                  spreadRadius: 2)
            ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: icon,
        ),
          const SizedBox(
            height: 5,
          ),
          Text(name, style: const TextStyle(color: Colors.white))
        ]), 
      );
  }
}
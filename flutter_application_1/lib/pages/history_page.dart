import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/movie_service.dart';
import 'package:go_router/go_router.dart';

class HistoryPage extends StatelessWidget {
  MovieServices services = MovieServices();
  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // firestore.collection("users").get().then((value) {
    //   for (var doc in value.docs) {
    //     log("${doc.id} => ${doc.data()}");
    //   }
    // },);
    firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("transactions").get().then((value) {
      for (var doc in value.docs) {
        log("${doc.id} => ${doc.data()}");
      }
    },);
    return FutureBuilder(
      future: firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("transactions").get(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 4, 28, 69),
          body:Center(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                const Text("History", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Column(
                  //Text(e.data().toString() , textAlign: TextAlign.center, style:
                  //   const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                  children: snapshot.data!=null ? snapshot.data!.docs.map(((e) => 
                    Container(
                      width: 320,
                      height: 150,
                      margin: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      child: Center(
                        child: Text(
                          e.data().toString() , textAlign: TextAlign.center, 
                          style: const TextStyle( fontWeight: FontWeight.bold),
                        ),
                      ),
                    ))).toList()
                    : [const Text("No history")],
                ),
              ]
            ),
          )
        );
      }
    );
  }
}

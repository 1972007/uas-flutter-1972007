import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/movie_service.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DateFormat dateFormat = DateFormat("EEEE dd MMM yyyy HH:mm");
    
    
    var poppins = GoogleFonts.poppins(  fontWeight: FontWeight.bold,fontSize: 11);
    var poppinsWhite = GoogleFonts.poppins(  fontWeight: FontWeight.bold,  color: Colors.white);
    // firestore.collection("users").get().then((value) {
    //   for (var doc in value.docs) {
    //     log("${doc.id} => ${doc.data()}");
    //   }
    // },);

    // firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("transactions").get().then((value) {
    //   for (var doc in value.docs) {
    //     log("${doc.id} => ${doc.data()}");
    //   }
    // },);
    return FutureBuilder(
      future: firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("transactions").get(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 4, 28, 69),
          body:Center(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: 
              [
                    const SizedBox(height: 20,),
                    Text("Movie History", textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 20,),
                    Column(
                      //Text(e.data().toString() , textAlign: TextAlign.center, style:
                      //   const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                      children: snapshot.data!=null ? snapshot.data!.docs.map((e) 
                      {
                        log(dateFormat.format(DateTime.fromMillisecondsSinceEpoch(e.data()["time_bought"])).toString());
                        return InkWell(
                          onTap: () {
                            Map<String, dynamic> map = {};
                            for( var key in e.data().keys) {
                              map[key] = e.data()[key].toString();
                            }
                            context.goNamed("history_detail", queryParams: map);
                          },
                          child: Container(
                            width: 320,
                            height: 150,
                            margin: const EdgeInsets.all(7),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  const SizedBox(width: 20,),
                                  const Icon(Icons.movie_creation_outlined),
                                  const SizedBox(width: 20,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(e.data()["title"].toString().length > 25 ?
                                        "${e.data()["title"].toString().substring(0,22)}..." : e.data()["title"].toString() ,
                                        textAlign: TextAlign.center, 
                                        style: poppins,),
                                      Text("Theatre ${e.data()["theatre"]} Chair ${e.data()["chair"]}" , textAlign: TextAlign.center, 
                                        style: poppins,),
                                      Text("Bought on ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(e.data()["time_bought"]))}" , textAlign: TextAlign.center, 
                                        style: poppins,),
                                      Text("Watch on ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(e.data()["time_watch"]))}" , textAlign: TextAlign.center, 
                                        style: poppins,),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );}
                      ).toList()
                      : 
                      [
                      Container(
                        width: 320,
                        height: 150,
                        padding:const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.not_interested, size: 30,),
                              const SizedBox(width: 20,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("No history",
                                    textAlign: TextAlign.center, 
                                    style: poppins),
                                  Text("Buy Some Tickets Or Look Around" , textAlign: TextAlign.center, style: poppins,),
                              ],
                            )
                          ],
                        ),
                    ),
                      ),
                  ],
                ),
              ]
            
            )
          )
        );
      }
    );
  }
}

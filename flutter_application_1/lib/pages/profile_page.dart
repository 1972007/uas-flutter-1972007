import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
//Firebase User object
//User(displayName: null, email: segantengariel@gmail.com, emailVerified: false, isAnonymous: false, metadata: UserMetadata(creationTime: 2022-11-27 09:46:53.040Z, lastSignInTime: 2022-12-14 05:59:01.382Z), phoneNumber: null, photoURL: null, providerData, [UserInfo(displayName: null, email: segantengariel@gmail.com, phoneNumber: null, photoURL: null, providerId: password, uid: segantengariel@gmail.com)], refreshToken: , tenantId: null, uid: RVDy7adhBpMSMdlvoJCIBeEafvK2)
class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    TextStyle poppinStyleBold = GoogleFonts.poppins(fontWeight: FontWeight.bold,  color: const Color.fromARGB(255, 255, 255, 255));   
    TextStyle poppins = GoogleFonts.poppins(color: const Color.fromARGB(255, 4, 28, 69));     
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    //  firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
    //    log(value.get("credit").toString());
    //  },);
    return FutureBuilder(
      future: firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder: (context, snapshot) {
        log(NumberFormat.currency(locale: "id", symbol: "Rp ").format( 
          snapshot.hasData? double.parse(snapshot.data!.get("credit").toString()): 0));
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 4, 28, 69),
          body:ListView(
            children:[
              const Icon(Icons.person, size: 100, color: Colors.white,),
              Center(child: Text(FirebaseAuth.instance.currentUser?.displayName ?? FirebaseAuth.instance.currentUser?.email ?? "Hello", style: poppinStyleBold,)),
              const SizedBox(height: 10,),
              Container(
                decoration:BoxDecoration(color: Colors.white, borderRadius:BorderRadius.circular(20) ),
                margin: const EdgeInsets.symmetric(horizontal:20),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Credits", textAlign: TextAlign.start, style: poppins,),
                        Text(NumberFormat.currency(locale: "id", symbol: "Rp ").format(
                          snapshot.hasData? double.parse(snapshot.data!.get("credit").toString()) : 0),
                          style: GoogleFonts.poppins(color: const Color.fromARGB(255, 4, 28, 69), fontWeight: FontWeight.bold),
                        ),
                      ]
                    ),
                    
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 4, 28, 69)
                      ),
                      onPressed:() {
                        context.goNamed("top_up");
                      },
                      child: Text("Top Up", style: GoogleFonts.poppins(color: Colors.white )),
                    )
                  ],
                ),
                )
              ]
            ),
        );
      }
    );
  }
}

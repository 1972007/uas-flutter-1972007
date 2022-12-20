import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/tresult/tresult.dart';
import 'package:flutter_application_1/services/movie_service.dart';
import 'package:go_router/go_router.dart';
//Firebase User object
//User(displayName: null, email: segantengariel@gmail.com, emailVerified: false, isAnonymous: false, metadata: UserMetadata(creationTime: 2022-11-27 09:46:53.040Z, lastSignInTime: 2022-12-14 05:59:01.382Z), phoneNumber: null, photoURL: null, providerData, [UserInfo(displayName: null, email: segantengariel@gmail.com, phoneNumber: null, photoURL: null, providerId: password, uid: segantengariel@gmail.com)], refreshToken: , tenantId: null, uid: RVDy7adhBpMSMdlvoJCIBeEafvK2)
class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 28, 69),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.person, size: 100, color: Colors.white,),
            Text(FirebaseAuth.instance.currentUser?.displayName ?? FirebaseAuth.instance.currentUser?.email ?? "Hello",      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            
          ]
        ),
      )
    );
  }
}

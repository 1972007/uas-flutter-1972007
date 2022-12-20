import 'dart:developer';

import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/bloc/bottom_nav_main/bottom_nav_main_bloc.dart';
import 'package:flutter_application_1/pages/detail_movie_page.dart';
import 'package:flutter_application_1/pages/email_sign_in_page.dart';
import 'package:flutter_application_1/pages/history_page.dart';
import 'package:flutter_application_1/pages/main_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() async {
  // MovieServices services = MovieServices();
  // TResult result = await services.getPopularMovies(page: 2);
  // List<Movie>? list = result.when(success: ((value) => value), failed: ((message) => null));
  // if(list!= null){
  //   print(list[1]);
  //   for (var element in list) {print(element); }
  // }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/login",
        name: "login",
        builder: ((context, state) => const EmailSignInPage())),
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) {
          return MainPage();
        },
        routes: [
          GoRoute(
            path: 'detail',
            name: 'detail',
            builder: (context, state) {
              return MovieDetailPage(movie_id: state.extra as int);
            },
          )
        ]
      ),
    ],
    initialLocation:
        FirebaseAuth.instance.currentUser != null ? "/main" : "/login",
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavMainBloc()..add(AppStarted()),
      child: BlocListener<BottomNavMainBloc, BottomNavMainState>(
        listener: (context, state) {
          FirebaseAuth.instance.currentUser != null ? router.goNamed("main") : router.goNamed("login");
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          routerDelegate: router.routerDelegate,
        ),
      ),
    );
    // MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(

    //     primarySwatch: Colors.blue,
    //   ),
    //   home: EmailSignInPage(),
    // );
  }
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/bottom_nav_main/bottom_nav_main_bloc.dart';
import 'package:flutter_application_1/bloc/date_watch/date_watch_bloc.dart';
import 'package:flutter_application_1/bloc/food_buy_history_switch/food_buy_history_switch_bloc.dart';
import 'package:flutter_application_1/bloc/food_cart/food_cart_bloc.dart';
import 'package:flutter_application_1/bloc/theatre_brand_bloc/theatre_brand_bloc.dart';
import 'package:flutter_application_1/bloc/theatre_chair/theatre_chair_bloc.dart';
import 'package:flutter_application_1/pages/buy_movie_page.dart';
import 'package:flutter_application_1/pages/detail_movie_page.dart';
import 'package:flutter_application_1/pages/email_sign_in_page.dart';
import 'package:flutter_application_1/pages/main_page.dart';
import 'package:flutter_application_1/pages/movie_food_completed_page.dart';
import 'package:flutter_application_1/pages/top_up_complete.dart';
import 'package:flutter_application_1/pages/top_up_page.dart';
import 'package:flutter_application_1/pages/transaction_complete_page.dart';
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
              log("Movie ID in MovieDetailPage : ${state.queryParams["movie_id"]}");
              return MovieDetailPage(
                movie_id:int.parse(state.queryParams["movie_id"]!), 
                isUpcoming: state.queryParams["isUpcoming"] =="true",);
            },
            routes: [
              GoRoute(
                path: "buy",
                name: "buy",
                builder: (context, state) {
                  log("${state.queryParams}");
                  return BuyMoviePage(
                    movie_id:int.parse(state.queryParams["movie_id"]!), 
                    title: state.queryParams["title"]!);
                },
                routes: [
                  GoRoute(
                    path: "complete",
                    name: "complete",
                    builder: (context, state) => 
                      TransactionCompletePage(state.queryParams),
                  )
                ]
              ),
            ]
          ),
          GoRoute(
            path: "food_completed",
            name: "food_completed",
            builder: (context, state) {
              return MovieFoodCompletedPage(state.extra as String);
            },
          ),
          GoRoute(
            path: "history_detail",
            name: "history_detail",
            builder: (context, state) => 
              TransactionCompletePage(state.queryParams),
            
          ),
          GoRoute(
            path: "top_up",
            name: "top_up",
            builder:(context, state) {
              return TopUpPage();
            },
            routes: [
              GoRoute(
                path: "top_up_complete",
                name: "top_up_complete",
                builder: (context, state) => TopUpCompletePage(state.queryParams),
              )
            ]
          ),
        ]
      ),
    ],
    initialLocation:
        FirebaseAuth.instance.currentUser != null ? "/main" : "/login",
  );

  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:  (context) => BottomNavMainBloc()..add(AppStarted())),
        BlocProvider(create: (context) => TheatreChairBloc()..add(ChairLoaded())),
        BlocProvider(create: (context) => TheatreBrandBloc()..add(TheatreLoaded())),
        BlocProvider(create: (context) => DateWatchBloc()..add(DateWatchLoaded())),
        BlocProvider(create:(context) => FoodCartBloc()..add(FoodCartLoaded())),
        BlocProvider(create:(context) => FoodBuyHistorySwitchBloc()..add(FoodBuyLoaded())),
      ], 
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
      ),
    );
    // return BlocProvider(
    //   create: (context) => BottomNavMainBloc()..add(AppStarted()),
    //   child: BlocListener<BottomNavMainBloc, BottomNavMainState>(
    //     listener: (context, state) {
    //       FirebaseAuth.instance.currentUser != null ? router.goNamed("main") : router.goNamed("login");
    //     },
    //     child: MaterialApp.router(
    //       debugShowCheckedModeBanner: false,
    //       routeInformationParser: router.routeInformationParser,
    //       routeInformationProvider: router.routeInformationProvider,
    //       routerDelegate: router.routerDelegate,
    //     ),
    //   ),
    // );
    // MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(

    //     primarySwatch: Colors.blue,
    //   ),
    //   home: EmailSignInPage(),
    // );
  }
}

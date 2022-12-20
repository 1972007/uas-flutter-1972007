import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/bottom_nav_main/bottom_nav_main_bloc.dart';
import 'package:flutter_application_1/pages/history_page.dart';
import 'package:flutter_application_1/pages/movie_choice_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  MovieChoicePage movieChoicePage = MovieChoicePage();
  HistoryPage historyPage = HistoryPage();
  ProfilePage profilePage = ProfilePage();
  @override
  Widget build(BuildContext context) {
    log("${FirebaseAuth.instance.currentUser}");
    // TODO: implement build
    return BlocBuilder<BottomNavMainBloc, BottomNavMainState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 4, 28, 69),
          appBar: AppBar(
            title: Text(FirebaseAuth.instance.currentUser?.email ?? ""),
            backgroundColor: const Color.fromARGB(255, 0, 20, 50),
            leading: IconButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .signOut()
                      .then((value) => context.goNamed("Login"));
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: BlocBuilder<BottomNavMainBloc, BottomNavMainState>(
            builder: (context, state) {
              if (state is CurrentIdxChanged) {
                log("${state.currentIdx}");
                if (state.currentIdx == 0) {
                  return movieChoicePage;
                }
                if (state.currentIdx == 1) {
                  return historyPage;
                }
                if (state.currentIdx == 2) {
                  return profilePage;
                }
              }
                  return movieChoicePage;
            },
          ),
          bottomNavigationBar: BlocBuilder<BottomNavMainBloc, BottomNavMainState>(
            builder: (context, state) {
              return BottomNavigationBar(
                currentIndex: state is CurrentIdxChanged ? state.currentIdx : 0,
                backgroundColor: const Color.fromARGB(255, 0, 20, 50),
                unselectedItemColor: const Color.fromRGBO(255, 255, 255, 0.8),
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.history), label: "History"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile")
                ],
                onTap: (value) {
                  context.read<BottomNavMainBloc>().add(PageTapped(idx: value));
                },
              );
            },
          ),
        );
      },
    );
  }
}

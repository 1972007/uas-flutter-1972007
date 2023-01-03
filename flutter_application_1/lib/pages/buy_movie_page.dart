import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/theatre_chair/theatre_chair_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../bloc/date_watch/date_watch_bloc.dart';
import '../bloc/theatre_brand_bloc/theatre_brand_bloc.dart';

class BuyMoviePage extends StatelessWidget {
  int movie_id;
  int price;

  String title;
  int chair_count_width = 20;
  int chair_count_height = 10;
  List<String> theatres = const["Select","XXI", "CGV", "Cinepolis", "Movimax", "Indiskop"];
  DateTime time_watch = DateTime.now();
  DateTime time_now = DateTime.now();
  Map<String, dynamic> data = {};
  DateFormat dateFormat = DateFormat("EEEE, d MMM yyyy");
  var _firestoreUserDoc = FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid);
  
  BuyMoviePage(
      {super.key,
      required this.movie_id,
      this.title = "Movie",
      this.price = 50000});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 28, 69),
      appBar: AppBar(
        title: Text("Buy Ticket", style: GoogleFonts.poppins(),),
        backgroundColor: const Color.fromARGB(255, 0, 20, 50),
        leading: IconButton(
            onPressed: () {
              context.pushNamed("detail",
                  queryParams: {"movie_id": movie_id.toString()});
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView(children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style:
              GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const Icon(
          Icons.tv_rounded,
          size: 200,
          color: Colors.white,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Choose Theatre",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: BlocBuilder<TheatreBrandBloc, TheatreBrandState>(
                    builder: (context, state) {
                      return DropdownButton(
                          dropdownColor: Colors.blue.shade900,
                          value: state is TheatreChanged
                              ? (state).theatre
                              : theatres[0],
                          items: theatres
                              .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              context
                                  .read<TheatreBrandBloc>()
                                  .add(TheatreChose(theatre: value));
                            }
                          });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  "Choose Date",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<DateWatchBloc, DateWatchState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: (() async {
                        showDatePicker(
                                context: context,
                                initialDate: time_now,
                                firstDate: time_now.subtract(const Duration(days: 30)),
                                lastDate: DateTime(time_now.year + 100))
                            .then((value) {
                          if (value != null) {
                            time_watch = value;
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now() )
                                .then((value) {
                              if (value != null) {
                                time_watch = DateTime(
                                    time_watch.year,
                                    time_watch.month,
                                    time_watch.day,
                                    value.hour,
                                    value.minute);
                                context
                                    .read<DateWatchBloc>()
                                    .add(DateWatchChose(time_watch));
                              }
                            });
                          }
                        });
                      }),
                      child: Container(
                        alignment: Alignment.center,
                        child: DropdownButton(
                            dropdownColor: Colors.blue.shade900,
                            items: [
                              DropdownMenuItem(
                                  child: Text(
                                      state is DateWatchChanged
                                          ? "${dateFormat.format(time_watch)}\n${state.dateTime.toString().substring(11, 19)}"
                                          : time_now.toString(),
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))
                            ],
                            onChanged: null),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Choose Chair",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: SizedBox(
            height: 280,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: List.generate(
                    chair_count_height,
                    (index2) => InkWell(
                      onTap: () {
                        context.read<TheatreChairBloc>().add(ChairTapped(
                            idx: index2 * chair_count_width + index + 1));
                        // log("${index2 * chair_count_width + index + 1}");
                      },
                      child: BlocBuilder<TheatreChairBloc, TheatreChairState>(
                        builder: (context, state) {
                          int chair_idx =
                              index2 * chair_count_width + index + 1;
                          return Container(
                            alignment: Alignment.center,
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                            decoration: BoxDecoration(
                                color: state is ChairIdxChanged &&
                                        chair_idx == state.idx
                                    ? Colors.indigo[800]
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "$chair_idx",
                              softWrap: true,
                              style: state is ChairIdxChanged &&
                                      chair_idx == state.idx
                                  ? GoogleFonts.poppins(
                                      fontSize: 10, color: Colors.white)
                                  : GoogleFonts.poppins(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                width: 5,
                height: 5,
              ),
              itemCount: chair_count_width,
            ),
          ),
        ),
        Center(
            child: Column(
          children: [
            BlocBuilder<TheatreBrandBloc, TheatreBrandState>(
              builder: (context, state) {
                if (state is TheatreChanged) {
                  data["theatre"] = state.theatre;
                }
                return Text(
                  state is TheatreChanged
                      ? "Bioskop ${state.theatre}"
                      : "Bioskop",
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            BlocBuilder<TheatreChairBloc, TheatreChairState>(
              builder: (context, state) {
                if (state is ChairIdxChanged) {
                  data["chair"] = state.idx;
                }
                return Text(
                  state is ChairIdxChanged ? "Kursi : ${state.idx}" : "",
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            BlocBuilder<TheatreChairBloc, TheatreChairState>(
              builder: (context, state) {
                data["price"] = price;
                return Text(
                  state is ChairIdxChanged ? "Rp. $price" : "",
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            BlocBuilder<DateWatchBloc, DateWatchState>(
              builder: (context, state) {
                return Text(state is DateWatchChanged ? dateFormat.format(state.dateTime) : "",
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.bold));
              },
            ),
            ElevatedButton(
                onPressed: (() {
                  data["time_bought"] = time_now.millisecondsSinceEpoch;
                  data["time_watch"] = time_watch.millisecondsSinceEpoch;
                  data["movie_id"] = movie_id;
                  data["title"] = title;
                  int money = 0;
                  _firestoreUserDoc.get().then((value){
                    money = (value.data()!["credit"]);
                    if (FirebaseAuth.instance.currentUser != null) {
                      if (data["time_bought"] != null &&
                          data["time_watch"] != null &&
                          data["theatre"] != null &&
                          data["chair"] != null &&
                          data["price"] != null &&
                          data["movie_id"] != null &&
                          data["title"] != null &&
                          data["price"] <= money) {
                            log("Success");
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("transactions")
                            .add(data)
                            .then((value) {
                          _firestoreUserDoc.update({"credit" : money-data["price"]});
                          context.goNamed("complete", queryParams: {
                            for (var e in data.keys) e: data[e].toString()
                          });
                        });
                      }
                      else{
                        log("Failed ${data} $money");
                      }
                    }
                  });
                  
                  
                }),
                child: Text("Buy Ticket", style: GoogleFonts.poppins(),)),
          ],
        )),
      ]),
    );
  }
}

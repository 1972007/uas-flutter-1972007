import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/food_buy_history_switch/food_buy_history_switch_bloc.dart';
import 'package:flutter_application_1/entities/food/food.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../bloc/food_cart/food_cart_bloc.dart';
import '../bloc/theatre_brand_bloc/theatre_brand_bloc.dart';

class MovieFoodPage extends StatelessWidget {
  MovieFoodPage({super.key});
  final _firestoreUserDoc = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    List<String> theatres = const [
      "Select",
      "XXI",
      "CGV",
      "Cinepolis",
      "Movimax",
      "Indiskop"
    ];

    String theatre_choosen = theatres[0];
    var poppins = GoogleFonts.poppins(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15);
    var poppins2 = GoogleFonts.poppins(color: Colors.white, fontSize: 11);
    var poppinsBlack = GoogleFonts.poppins( fontSize: 11, fontWeight: FontWeight.bold);
    List<Food> foods = const [
      Food(
          id: 1,
          name: "Popcorn",
          price: 25000,
          linkImg: "https://i.postimg.cc/YSyxkPgM/popcorn.jpg"),
      Food(
          id: 2,
          name: "Hot Dog",
          price: 25000,
          linkImg: "https://i.postimg.cc/85JmCbBW/hot-dog.jpg"),
      Food(
          id: 3,
          name: "Cola",
          price: 25000,
          linkImg: "https://i.postimg.cc/Sxdr1RxX/cola.jpg"),
      Food(
          id: 4,
          name: "Milo",
          price: 25000,
          linkImg: "https://i.postimg.cc/d009bFh5/milo.jpg"),
    ];
    var poppins3 =
        GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold);
    DateFormat dateFormat = DateFormat("EEEE dd MMM yyyy HH:mm");
    
    return ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Center(
                  child:
                      // Text("Food For Movies", textAlign: TextAlign.left, style: poppins)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Choose Page',
                          style: poppins3,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        BlocBuilder<FoodBuyHistorySwitchBloc,FoodBuyHistorySwitchState>(
                          builder: (context, state) {
                            return DropdownButton<String>(
                              items: const [
                                DropdownMenuItem(
                                    value: "Food For Movies",
                                    child: Text("Food For Movies",
                                        textAlign: TextAlign.left)),
                                DropdownMenuItem(
                                    value: "Food Order History",
                                    child: Text("Food Order History",
                                        textAlign: TextAlign.left))
                              ],
                              style: poppins3,
                              dropdownColor: const Color.fromARGB(255, 4, 28, 69),
                              value: state is CurrentValChanged ? state.val : "Food For Movies",
                              underline: Container(),
                              isDense: true,
                              onChanged: (value) {
                                if(value!=null){
                                  context.read<FoodBuyHistorySwitchBloc>().add(FoodBuySwitchTapped(value));
                                }
                              },
                            );
                          },
                        ),
                      
                  ],
              )
            ),
            BlocBuilder<FoodBuyHistorySwitchBloc,FoodBuyHistorySwitchState>(
              builder: (context, state) {
                log("$state");
                 
                if(state is CurrentValChanged  && state.val=="Food Order History") {
                 return FutureBuilder(
                  future: _firestoreUserDoc.collection("food_bought").get(),
                  builder:(context, snapshot) {
                    return Column(
                      children: snapshot.data!=null ? snapshot.data!.docs.map<Widget>(
                        (e) {
                          return InkWell(
                            onTap: () {
                              context.goNamed("food_completed",extra: e.id);
                            },
                            child:  Container(
                              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child:Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [ 
                                    const Icon(Icons.fastfood, color:Color.fromARGB(255, 4, 28, 69) ,),
                                     
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Order no ${e.id}" ,
                                          textAlign: TextAlign.center, 
                                          style: poppinsBlack,),
                                        Text("${e.data()["price"]}" , textAlign: TextAlign.center, 
                                          style: poppinsBlack,),
                                        Text("Bought on ${
                                            dateFormat.format(DateTime.fromMillisecondsSinceEpoch(e.data()["date"]))
                                          }" , textAlign: TextAlign.center, 
                                          style: poppinsBlack,),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ),
                          );
                        }
                      ).toList()
                      : [],
                    );
                  },
                );
                    

                } 
                else  {
                  return Column(
                    children: foodList(foods, poppins, poppins2, theatre_choosen, theatres) 

                  );
                }
                },
              ),
          ]
        );
  }

  List<Widget> checkOut(String theatre_choosen, List<String> theatres, ) {
    return [
      BlocBuilder<FoodCartBloc, FoodCartState>(
        builder: (context, state) {
          log(state is FoodCartRunning
              ? state.foodCart.foods.toString()
              : "No Data");
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${state is FoodCartRunning ? state.foodCart.totalValue() : 0} Item",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 4, 28, 69)),
                        ),
                        Text(
                          NumberFormat.currency(
                                  locale: "id", symbol: "Rp ", decimalDigits: 0)
                              .format(state is FoodCartRunning
                                  ? state.foodCart.totalPrice()
                                  : 0),
                          style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 4, 28, 69),
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                  Row(
                    children: [
                      BlocBuilder<TheatreBrandBloc, TheatreBrandState>(
                        builder: (context, state) {
                          if (state is TheatreChanged) {
                            log("$state");
                            theatre_choosen = state.theatre;
                          }
                          return Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 4, 28, 69),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton(
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                dropdownColor:
                                    const Color.fromARGB(255, 4, 28, 69),
                                value: state is TheatreChanged
                                    ? (state).theatre
                                    : theatres[0],
                                items: theatres
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(
                                            e,
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    context
                                        .read<TheatreBrandBloc>()
                                        .add(TheatreChose(theatre: value));
                                  }
                                }),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 13),
                            backgroundColor:
                                const Color.fromARGB(255, 4, 28, 69)),
                        onPressed: () {
                          if (state is FoodCartRunning &&
                              state.foodCart.foods.isNotEmpty) {
                            var foodCart = state.foodCart;
                            Map<String, dynamic> map = foodCart.toJson()
                              ..addEntries({
                                "price": foodCart.totalPrice(),
                                "payment_method": "cash",
                                "date": DateTime.now().millisecondsSinceEpoch
                              }.entries);
                            log(map.toString());
                            _firestoreUserDoc.get().then((value) {
                              var data = (value.data());
                              log("Loaded $data");
                              if (FirebaseAuth.instance.currentUser != null &&
                                  data != null) {
                                if (map["order"].isNotEmpty &&
                                    theatre_choosen != theatres[0] &&
                                    map["price"] <= data["credit"]) {
                                  log(
                                    "Uploaded",
                                  );
                                  _firestoreUserDoc
                                      .collection("food_bought")
                                      .add(map)
                                      .then(
                                    (value) {
                                      // _firestoreUserDoc.update({"credit" : data["credit"]-map["price"]});
                                      context.goNamed("food_completed",
                                          extra: value.id);
                                    },
                                  );
                                }
                              }
                            });
                          }
                        },
                        child: Text("Check Out",
                            style: GoogleFonts.poppins(color: Colors.white)),
                      ),
                    ],
                  )
                ],
              ));
        },
      ),
    ];
  }

  List<Widget> foodList(
      List<Food> foods, TextStyle poppins, TextStyle poppins2,String theatre_choosen, List<String> theatres,) {
    return foods.map<Widget>((e) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 77,
              height: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(e.linkImg),
                    fit: BoxFit.scaleDown,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.name, textAlign: TextAlign.left, style: poppins),
                Text(
                    NumberFormat.currency(locale: "id", symbol: "IDR")
                        .format(e.price),
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text(
                    e.desc.length > 25
                        ? "${e.desc.substring(0, 25)}..."
                        : e.desc,
                    textAlign: TextAlign.left,
                    style: poppins2),
              ],
            ),
            BlocBuilder<FoodCartBloc, FoodCartState>(
              builder: (context, state) {
                log("$state ");
                return Row(children: [
                  InkWell(
                    onTap: () {
                      context.read<FoodCartBloc>().add(AddFood(e));
                      // log(state is FoodCartRunning && state.foodCart.foods[e] !=null ?
                      // state.foodCart.foods[e].toString()
                      // :"No data, state = $state");
                    },
                    child: const Icon(
                      Icons.add_circle,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                      state is FoodCartRunning &&
                              state.foodCart.foods[e] != null
                          ? state.foodCart.foods[e].toString()
                          : "0",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 14)),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () =>
                        context.read<FoodCartBloc>().add(RemoveFood(e)),
                    child: const Icon(
                      Icons.remove_circle,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ]);
              },
            )
          ],
        ),
      );
    }).toList() + checkOut(theatre_choosen, theatres);
  }
}

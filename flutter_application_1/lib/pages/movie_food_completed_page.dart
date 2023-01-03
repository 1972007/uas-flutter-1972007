import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/food_cart/food_cart.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../entities/food/food.dart';

class MovieFoodCompletedPage extends StatelessWidget{
  String doc_id;
  //Map<String,dynamic> map = {
  //   "order": [
  //       "Cola" : food.fromJsom()
  //       "Hot Dog" : 
  //    ],
  //   "price": state.foodCart.totalPrice(),
  //   "payment_method" : "cash",
  //   "date":DateTime.now().millisecondsSinceEpoch
  //};   
  
  Map<Food, int> foods = {};
  FoodCart foodCart =const FoodCart({});
  Map<String, dynamic> data ={};

  DateFormat dateFormat = DateFormat("EEEE dd MMM yyyy HH:mm");
  MovieFoodCompletedPage(this.doc_id, {super.key});
  var format_number = NumberFormat.currency(locale: "id", symbol: "Rp ",decimalDigits: 0).format;
  final _firestoreUserDoc = FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid);
  
  Future<DocumentSnapshot<Map<String, dynamic>>>? getFuture() async{
     DocumentSnapshot<Map<String, dynamic>> future = await _firestoreUserDoc.collection("food_bought").doc(doc_id).get();
        if(future.data()!=null){
          for (var food in future.data()!["order"].values ){
            foods[Food.fromJson(food)] = food["total"];
          }
          data = future.data()!;
          foodCart = FoodCart(foods);
          log("${foodCart.foods}");
          log("This is data $data");
        }

    return future;
  }

  @override
  Widget build(BuildContext context) {
   
    var poppins = GoogleFonts.poppins(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15);
    var poppins2 = GoogleFonts.poppins(color: Colors.white, fontSize: 11);
    return  FutureBuilder(
      
      future: getFuture(),
      builder: (context, snapshot) {
          log("${foodCart.foods}");
          log("This is data $data");
        // _firestoreUserDoc.collection("food_bought").doc(doc_id).get().then((value) {
        //   data = value.data()!;
        //   for (var food in value.data()!["order"].values ){
        //     foods[Food.fromJson(food)] = food["total"];
        //   }
        //   foodCart = FoodCart(foods);
        //   log("${value.data()!["order"]}");
        // });        
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 4, 28, 69),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 0, 20, 50),
            title: Text("Transaction Completed", style: GoogleFonts.poppins(),),
            leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {context.goNamed("main");},),
          ),
          body: 
          Center(
            child: ListView(
              
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      const SizedBox(height: 10,), 
                        const Icon(Icons.check_circle, color:  Color.fromARGB(255, 38, 65, 218),size: 200,),
                        const SizedBox(height: 10,),
                        Text("Transaction Completed", style: GoogleFonts.poppins(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10,),
                        Text(format_number(data["price"] ?? 0), style: GoogleFonts.poppins(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20,),
                        Text("Bought On\n${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(data["date"] ?? 0))}",
                          textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: foods.keys.map<Widget>((e) {
                            return Container(
                              margin: const EdgeInsets.fromLTRB(0, 0,20, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                      Text("${foodCart.getFoodBought(e)} ${e.name} x ${NumberFormat.currency(locale: "id", symbol: "Rp ")
                                              .format(e.price)}", textAlign: TextAlign.left, style: poppins),
                                      Text(
                                          NumberFormat.currency(locale: "id", symbol: "Rp ")
                                              .format(e.price * foodCart.getFoodBought(e)),
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                              color: Colors.white, fontWeight: FontWeight.bold)),
                                      Text(e.desc.length> 25 ? "${e.desc.substring(0,25)}...":e.desc, textAlign: TextAlign.left, style: poppins2),
                                    ],
                                  ),
                                ]
                              )
                            );
                          }).toList()
                      ),
                      const SizedBox(height: 20,),
                    ],
                  
                  ),
                )
              ]
              
            ),
          ),
          
        );
      }
    );
  }
  
}

// foods.keys.map((e) {
                        
//                       }
//                     ).toList()
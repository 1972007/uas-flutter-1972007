import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TopUpPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    DateTime time_now = DateTime.now();
    var format_number = NumberFormat.currency(locale: "id", symbol: "Rp ",decimalDigits: 0).format;
    TextEditingController amountController = TextEditingController();
    var firestoreUserDoc = FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid);
  
    var poppins = GoogleFonts.poppins(color: Colors.white);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 20, 50),
        title: Text("Top Up", style: poppins,),
        leading: IconButton(
          onPressed: () {
            context.go("/main");
          },
          icon: const Icon(Icons.arrow_back)
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 4, 28, 69),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                    onChanged: (value) {
                      log(value);
                     // value = format_number(int.parse(value));
                      amountController.value = TextEditingValue(
                        text: value,
                        selection: TextSelection.collapsed(offset: value.length)
                      );
                      log(value);
                    },
                    style: poppins,
                    decoration: InputDecoration(
                      hintText:  format_number(0) ,
                      label: Text("Type Your Amount", style: poppins,),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      hintStyle: poppins
                    ),
                    controller:amountController ,
                  ),
                ),
                
              ]
            ),
            Container(
              alignment: Alignment.centerRight,
              child: ElevatedButton(onPressed:() {
                int money = 0;
                firestoreUserDoc.get().then((value) {
                  money = value.data()!["credit"];
                  if (amountController.text.isNotEmpty) {
                    Map<String, dynamic> map = {
                      "money": int.parse(amountController.text),
                      "money_source" : "cash",
                      "time": time_now.millisecondsSinceEpoch
                    };
                    
                    FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("top_up")
                      .add(map).then((value) {
                        firestoreUserDoc.update({"credit" : money+map[ "money"]});
                        context.goNamed("top_up_complete",queryParams:
                          {for (var e in map.keys) e: map[e].toString()});
                        },);
                }});
              }, 
              child: Text("Top Up", style: GoogleFonts.poppins(),)),
            )
          ],
        ),
      ),
    );
  }
}
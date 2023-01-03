 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
//{theatre: XXI, 
//chair: 198, 
//price: 50000, 
//time_bought: 1672054536099, 
//time_watch: 1672311600000, 
//movie_id: 736526, title: Troll}
class TransactionCompletePage extends StatelessWidget{
  Map<String, dynamic> data;
  DateFormat dateFormat = DateFormat("EEEE dd MMM yyyy HH:mm");
  TransactionCompletePage(this.data, {super.key});
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 28, 69),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 20, 50),
        title: Text("Transaction Completed", style: GoogleFonts.poppins(),),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {context.goNamed("main");},),
      ),
      body:  Center(
        child: Column(
          children: 
            [const SizedBox(height: 10,), 
            const Icon(Icons.check_circle, color:  Color.fromARGB(255, 38, 65, 218),size: 200,),
            const SizedBox(height: 10,),
            Text("Transaction Completed", style: GoogleFonts.poppins(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10,),
            Text("Rp ${data["price"]}", style: GoogleFonts.poppins(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20,),
            Text("On Cinema ${data["theatre"]}", style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5,),
            Text("Chair ${data["chair"]}", style:GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20,),
            Text("Movie Title", style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5,),
            Flexible(child: Text(data["title"].toString(), textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold))),
            const SizedBox(height: 20,),
            Text("Bought On\n${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(data["time_bought"])))}",
              textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20,),
            Text("To Be Watched On Date\n${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(data["time_watch"])))}",
              textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
           ],),
      ),
        
      );
    
  }
}
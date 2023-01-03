import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TopUpCompletePage extends StatelessWidget{
  //{money : 50000,
  //money_source : "cash",
  //time: 1672064644744}
  DateFormat dateFormat = DateFormat("EEEE, d MMM yyyy");
  Map<String, dynamic> data = {};
  TopUpCompletePage(this.data, {super.key});
  var format_number = NumberFormat.currency(locale: "id", symbol: "Rp ",decimalDigits: 0).format;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          [
            const SizedBox(height: 10,), 
            const Icon(Icons.check_circle, color:  Color.fromARGB(255, 38, 65, 218),size: 200,),
            const SizedBox(height: 10,),
            Text("Transaction Completed", style: GoogleFonts.poppins(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10,),
            Text("${format_number(int.parse(data["money"]))} Added", style: GoogleFonts.poppins(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
            
            Text("Bought On Date\n${dateFormat.format(
                DateTime.fromMillisecondsSinceEpoch(
                  int.parse(data["time"])))}",
              textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20,),
            Text("Payment : ${data["money_source"]}", style: GoogleFonts.poppins(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
            
          ]
       ,),
      ),
        
    );
  }
}
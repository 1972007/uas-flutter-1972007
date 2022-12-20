import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailSignInPage extends StatelessWidget{
  const EmailSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    emailController.text = FirebaseAuth.instance.currentUser?.email ?? "";

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 28, 69),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* TITLE
            const Text("SIGN IN WITH EMAIL", style:TextStyle(color: Colors.white),),
            const SizedBox(height: 10),
            StreamBuilder<User?>(
              stream: FirebaseAuth.instance.userChanges(),
              builder: ((context, snapshot) =>
                snapshot.hasData ? Text("Welcome back, ${snapshot.data?.email}", style: const TextStyle(color: Colors.white),) : const Text("Welcome",style: TextStyle(color: Colors.white),)
              ),
            ),
            const SizedBox(height: 10),
            
            //* EMAIL FIELD
            Container(
              margin: const EdgeInsets.fromLTRB(30, 15, 30, 0),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(45)
              ),
              child: TextField(
                controller: emailController,
                cursorColor: const Color.fromARGB(255, 18, 68, 94),
                decoration: const InputDecoration(
                  fillColor: Color.fromRGBO(152, 183, 208, 1),
                  border: InputBorder.none, hintText: "Email",
                ),
              ),
            ),
            const SizedBox(height: 10),
            
            //* PASS FIELD
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(45)
              ),
              child: TextField(
                controller: passwordController,
                cursorColor: const Color.fromARGB(255, 18, 68, 94),
                decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Password"
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //* SIGN UP
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 29, 98, 151))),
                    onPressed: () async { 
                      try{
                        if(FirebaseAuth.instance.currentUser==null){
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                        }else{
                          await FirebaseAuth.instance.signOut();
                        }
                      }
                      on FirebaseAuthException catch(e){
                        showNotif(context, e.message.toString());
                      }
                    },
                    child:StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.userChanges(),
                      builder: ((context, snapshot) =>
                        snapshot.hasData ? const Text("Sign Out") : const Text("Sign Up")
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                //* SIGN IN
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 29, 98, 151))),
                    onPressed: () async { 
                      try{
                        if(FirebaseAuth.instance.currentUser==null){
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                          context.goNamed("main");
                        }else{
                          await FirebaseAuth.instance.signOut();
                        }
                      }
                      on FirebaseAuthException catch(e){
                        showNotif(context, e.message.toString());
                      }
                    },
                    child: const Text("Sign In"),
                    
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            
            TextButton(onPressed: () async{
              try{
                await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
              }on FirebaseAuthException catch (e){
                showNotif(context, e.message.toString());
              }
            }, child: const Text("Reset Password",style: TextStyle(fontWeight: FontWeight.bold,  color: Color.fromARGB(255, 29, 98, 151)), ),),
          ],
        )
      ),
    );
  }

  void showNotif(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: const Color.fromARGB(255, 29, 98, 151), content: Text(message.toString())));
  }
}
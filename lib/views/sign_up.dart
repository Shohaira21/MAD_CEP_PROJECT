



import 'package:blogging/views/auth_service.dart';
import 'package:blogging/views/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController ec=TextEditingController();

  TextEditingController pc=TextEditingController();

  TextEditingController namec=TextEditingController();

   bool isLoggingIn = false; 

  final AuthService authService = AuthService();

  //FirebaseFirestore firestore = FirebaseFirestore.Instance;
  CollectionReference users= FirebaseFirestore.instance.collection("user");

  @override
  Widget build(BuildContext context) {

    signUp() async {
    final User? user=await authService.signUp(
      ec.text,
      pc.text);
      users.add({"name":namec.text,"email":ec.text,"password":pc.text,});
      
      if(user != null) {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sign up")));
       }
  }
  signIn() async {
  final User? user = await authService.signIn(
    ec.text,
    pc.text,
  );

  if (user != null) {
    // Navigate to a new screen with the success message
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  } else {
    // ignore: avoid_print
    print("Something went wrong!!");
  }
}


    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
//             //Image animation
//            Container(
//                         margin: const EdgeInsets.fromLTRB(15, 40, 15, 10),
//                         width: MediaQuery.of(context).size.width,
//                         child:Image.asset("assets/2.jpg")
//  // Use the asset path here
// ),

            // Animated login container
            // AnimatedContainer(
            //   duration: Duration(milliseconds: 500), // Animation duration
            //   height: isLoggingIn ? 50 : 0, // Adjust the height as needed
            //   child: isLoggingIn
            //       ? Center(
            //           child: CircularProgressIndicator(),
            //         )
            //       : null,
            // ),

            const SizedBox(height: 20, width: 45,),
            TextFormField(
              controller: namec,
              decoration: const InputDecoration(
                label: Text("Username")
                
              ),
            ),
           
            TextFormField(
              controller: ec,
              decoration: const InputDecoration(
                label: Text("Email")
              ),
            ),
            TextFormField(
              controller: pc,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text("Password")
                
              ),
            ),
            const SizedBox(height: 20,width: 45,),
            ElevatedButton(
              onPressed: () {signIn();},
               child: const Text("Log In")),
               const SizedBox(height: 20,width: 45,),
                ElevatedButton(
              onPressed: () {signUp();},
               child: const Text("Sign Up")),                       
              
         ],
        ),
      ),
    );
  }
}

// ElevatedButton(
//               onPressed: () {
//                 _signOut(context);
//               },
//               child: const Text('Sign Out'),
//             ),
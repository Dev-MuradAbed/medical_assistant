// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:medical_assistant/screen/home_screen.dart';
// import 'package:medical_assistant/screen/login_screen.dart';
// class UserManagment{
//   Widget handleAuth(){
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (BuildContext context, snapshot){
//         if(snapshot.hasData){
//           return HomeScreen();
//         }
//         return LoginScreen();
//       },
//     );
//   }
//   authorizeAccess(BuildContext context){
//     FirebaseAuth.instance.userChanges().listen((user) {
//       FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then((docs) {
//         if(docs[0].exists){
//           if(docs[0].data()!['role']=='admin'){
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
//           }else if(docs[0].data()!['role']=='Patient'){
//             Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => const HomeScreen(), ));
//           }
//           print('user Authorized');
//         }else{
//      print('Not Authorized');
//         }
//       });
//     });
//
//   }
//   void signOut(){
//     FirebaseAuth.instance.signOut();
//   }
// }
//

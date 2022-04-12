// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:medical_assistant/screen/home_screen.dart';
// import 'package:medical_assistant/screen/login_screen.dart';
// class UserManagment{
//   Widget handleAuth(){
//     return LoginScreen();
//     // return StreamBuilder(
//     //   stream: FirebaseAuth.instance.authStateChanges(),
//     //     builder: (BuildContext context, snapshot){
//     //     if(snapshot.hasData){
//     //       return HomeScreen(titile: 'here',);
//     //       // return HomeScreen();
//     //     }
//     //     return LoginScreen();
//     //     // return LoginScreen();
//     //   },
//     // );
//   }
//   authorizeAccess(BuildContext context){
//     FirebaseAuth.instance.userChanges().listen((user) {
//       FirebaseFirestore.instance.collection('UserData').doc(user!.uid).get().then((docs) {
//         if(docs.exists){
//         print("Here is the user data,,,${docs[0].data()!['role']}");
//           if(docs[0].data()!['role']=='user'){
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen(titile: 'admin',)));
//           print('user Authorized');
//         }else{
//      print('Not Authorized');
//         }
//       }}).catchError((e){
//         print(e);
//       });
//     });
//
//   }
//   void signOut(){
//     FirebaseAuth.instance.signOut();
//   }
// }
//

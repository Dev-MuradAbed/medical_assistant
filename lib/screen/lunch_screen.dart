import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_assistant/bottom_navigation_bar.dart';
import '../widgets/grident_text.dart';
import 'auth/login_screen.dart';



class LunchScreen extends StatefulWidget {
  const LunchScreen({Key? key}) : super(key: key);

  @override
  State<LunchScreen> createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen> {


  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () async{
      FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/button_navigator_bar');

        }else{
          Navigator.pushReplacementNamed(context, '/login_screen');
        }
      });

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset('assets/images/logo.svg'),
                const SizedBox(height: 20),
                GradientText(
                  'Medical Assistant',
                  style: const TextStyle(

                    fontSize: 30.0,
                   // fontWeight: FontWeight.bold,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade500,
                      Colors.green.shade900,
                      Colors.green.shade500,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

}

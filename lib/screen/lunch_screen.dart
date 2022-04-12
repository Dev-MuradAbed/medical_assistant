import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_assistant/api/local_auth_api.dart';

import '../widgets/grident_text.dart';



class LunchScreen extends StatefulWidget {
  const LunchScreen({Key? key}) : super(key: key);

  @override
  State<LunchScreen> createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds:3), () {
      Navigator.pushReplacementNamed(context, '/login_screen');
    });

    // TODO: implement initState
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

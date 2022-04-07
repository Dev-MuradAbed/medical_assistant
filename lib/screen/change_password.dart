

import 'package:flutter/material.dart';

import '../them.dart';
import '../widget/button_widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: blueClr,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Forget Password",
          style: TextStyle(
            color: blueClr,
            fontSize: 25,
            fontFamily: 'Candara',
            fontWeight: FontWeight.bold,
          ),
        ),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Password Recovery',
            style: TextStyle(
              fontFamily: 'Candara',
              color: blueClr,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Enter 4 number code sent you\non your your email address',
            style: TextStyle(
              fontFamily: 'Candara',
              color: blackClr,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'ao*****57@gmail.com',
            style: TextStyle(
              fontFamily: 'Candara',
              color: blackClr,
              letterSpacing: 1.2,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          const SizedBox(height: 50),
          ButtonWidget(text: 'Save', onPressed: () {}),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}

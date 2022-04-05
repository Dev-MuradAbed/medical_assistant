import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_assistant/them.dart';

import '../widget/choose_job.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'LOG IN',
          style: TextStyle(
            fontFamily: 'Candara',
            color: Color(0xff184093),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const ChooseJob(),
              const SizedBox(height: 30),
              TextFormField(

                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        border:Border.all(
                          color: greenClr,
                          width:1.5
                        ),
                        borderRadius: BorderRadius.circular(15),

                      ),
                      child: const Text(
                        'ENTER ID',
                        style: TextStyle(
                          color: blueClr,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    focusColor: greenClr,
                    border: OutlineInputBorder(
                      borderSide:const BorderSide(
                        color:greenClr,
                        width:1.5
                      ),
                      borderRadius: BorderRadius.circular(25),

                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

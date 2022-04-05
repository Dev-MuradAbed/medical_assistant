import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_assistant/them.dart';

import 'package:medical_assistant/widget/text_field.dart';

import '../widget/choose_job.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassword = true;
  late TextEditingController _idController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    _idController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
        child: ListView(children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ChooseJob(),
                const SizedBox(height: 39),
                TextInput(
                    label: 'Enter ID',
                    controller: _idController,
                    keyboardType: TextInputType.number,
                    oreIcon: Icons.person),
                const SizedBox(height: 20),
                TextInput(
                  label: 'password',
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  oreIcon: Icons.lock,
                  onChanged: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  obscureText: isPassword,
                  sufIcon: isPassword == true
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsetsDirectional.only(end: 20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'FORGET PASSWORD ?',
                      style: TextStyle(
                        fontFamily: 'Candara',
                        color: blueClr,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed:loginPer,
                  child: const Text(
                    'LOG IN',
                    style: TextStyle(
                      fontFamily: 'Candara',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: greenClr,
                    minimumSize: const Size(160, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'YOU DON\'T HAVE ANY ACCOUNT ? SGIN UP.',
                  style: TextStyle(
                    fontFamily: 'Candara',
                    color: greenClr,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '- OR - ',
                  style: TextStyle(
                    fontFamily: 'Candara',
                    color: blueClr,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 35),
                SvgPicture.asset('assets/images/fig.svg')
              ],
            ),
          ),
        ]),
      ),
    );
  }

  loginPer() {
    if(check()){
      login();
    }
  }

  bool check() {
    if (_idController.text.isNotEmpty &&
        _idController.text.length == 9 &&
        _passwordController.text.isNotEmpty) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(

      content: const Text('Enter Valid ID and Password'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),);
    return false;
  }

  login() {
   Navigator.pushReplacementNamed(context, '/home_screen');
  }
}

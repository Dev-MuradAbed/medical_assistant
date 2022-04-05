import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:medical_assistant/api/local_auth_api.dart';
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
                  onpressed: () {
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
                  onPressed: loginPer,
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
                // buildAuthenticate(context),
                // buildAvailability(context),
                GestureDetector(
                    onTap: () async {
                      final isAuthenticated = await LocalAuthApi.authenticate();

                      if (isAuthenticated) login();
                    },
                    child: SvgPicture.asset('assets/images/fig.svg'))
              ],
            ),
          ),
        ]),
      ),
    );
  }

  loginPer() {
    if (check()) {
      login();
    }
  }

  bool check() {
    if (_idController.text.isNotEmpty &&
        _idController.text.length == 9 &&
        _passwordController.text.isNotEmpty) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Enter Valid ID and Password'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
    return false;
  }

  login() {
    Navigator.pushReplacementNamed(context, '/home_screen');
  }

  Widget buildAvailability(BuildContext context) => buildButton(
        text: 'Check Availability',
        icon: Icons.event_available,
        onClicked: () async {
          final isAvailable = await LocalAuthApi.hasBiometrics();
          final biometrics = await LocalAuthApi.getBiometrics();

          final hasFingerprint = biometrics.contains(BiometricType.fingerprint);

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Availability'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildText('Biometrics', isAvailable),
                  buildText('Fingerprint', hasFingerprint),
                ],
              ),
            ),
          );
        },
      );

  Widget buildText(String text, bool checked) => Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            checked
                ? Icon(Icons.check, color: Colors.green, size: 24)
                : Icon(Icons.close, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: 24)),
          ],
        ),
      );

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );
}

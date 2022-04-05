import 'package:flutter/material.dart';

import 'package:medical_assistant/widget/text_field.dart';

import '../widget/choose_job.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const ChooseJob(),
              const SizedBox(height: 30),
              TextInput(
                  label: 'Enter ID',
                  controller: _idController,
                  keyboardType: TextInputType.number,
                  oreIcon: Icons.person
              ),
              TextInput(
                label: 'password',
                controller: _passwordController,
                keyboardType: TextInputType.text,
                oreIcon: Icons.lock,
                obscureText: true,
                sufFirstIcon: Icons.visibility_off,
                sufSecondIcon: Icons.visibility,
              ),
            ],
          ),
        ),
      ),
    );
  }

}

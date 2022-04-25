
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



import 'package:medical_assistant/screen/profile_screen.dart';


import '../../theme.dart';
import '../../utils/helpers.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/choose_job.dart';
import '../../widgets/text_field.dart';

class LoginScreen extends StatefulWidget  {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>with Helper {
  bool isPassword = true;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextInput(
                    label: 'Enter Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    widgetIcon: const Icon(
                      Icons.person,
                      color: greenClr,
                      size: 22,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email cannot be empty";
                      }
                      if (!RegExp(
                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please enter a valid email");
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _emailController.text = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextInput(
                    label: 'password',
                    controller: _passwordController,
                    keyboardType: TextInputType.emailAddress,
                    widgetIcon: const Icon(
                      Icons.person,
                      color: greenClr,
                      size: 22,
                    ),
                    obscureText: isPassword,
                    sufWidget:IconButton(
                      icon: Icon(
                        isPassword ? Icons.visibility : Icons.visibility_off,
                        color: greenClr,
                        size: 22,
                      ),
                      onPressed: () {
                        setState(() {
                          isPassword = !isPassword;

                        });
                      },
                    ),
                    validator:  (value) {
                      RegExp regex = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      if (!regex.hasMatch(value)) {
                        return ("please enter valid password min. 6 character");
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _passwordController.text = value!;
                    },
                  ),
                  Padding(
                      padding: const EdgeInsetsDirectional.only(end: 20.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: ()=>Navigator.pushNamed(context, '/forget_screen'),
                          child: const Text('FORGET PASSWORD ?',
                            style:  TextStyle(
                              fontFamily: 'Candara',
                              color: blueClr,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: 20),
                  ButtonWidget(text: "LOG IN",
                      onPressed: ()=>signIn(_emailController.text,_passwordController.text)),
                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup_screen');
                    },
                    child:const Text ('YOU DON\'T HAVE ANY ACCOUNT ? SGIN UP.',
                      style: TextStyle(
                        fontFamily: 'Candara',
                        color: greenClr,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                  ),

                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showSnackBar(context, message: 'User Not Found', error: true);
        } else if (e.code == 'wrong-password') {
          showSnackBar(context, message: 'Wrong Password', error: true);
        }
      }
    }
  }
  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme.dart';
import '../../utils/custom_painter.dart';
import '../../utils/helpers.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helper {
  bool isPassword = true;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.13,
                    ),

                      CustomPaint(
                       size: const Size(double.infinity, 700),
                        foregroundPainter: RPSCustomPainter(),
                      ),

                  ],
                ),
              ),
              ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SvgPicture.asset('assets/images/logo.svg'),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 50),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextInput(
                              hint: AppLocalizations.of(context)!.email,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              widgetIcon: const Icon(
                                Icons.person,
                                color: greenClr,
                                size: 22,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return  AppLocalizations.of(context)!.email_can_not_be_empty;
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ( AppLocalizations.of(context)!.email_is_not_valid);
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
                              hint:  AppLocalizations.of(context)!.password,
                              controller: _passwordController,
                              keyboardType: TextInputType.emailAddress,
                              widgetIcon: const Icon(
                                Icons.lock,
                                color: greenClr,
                                size: 22,
                              ),
                              obscureText: isPassword,
                              sufWidget: IconButton(
                                icon: Icon(
                                  isPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: greenClr,
                                  size: 22,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPassword = !isPassword;
                                  });
                                },
                              ),
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return  AppLocalizations.of(context)!.password_can_not_be_empty;
                                }
                                if (!regex.hasMatch(value)) {
                                  return ( AppLocalizations.of(context)!.password_must_be_at_least_6_characters);
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                _passwordController.text = value!;
                              },
                            ),
                            Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 20.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, '/forget_screen'),
                                    child:  Text(
                                      AppLocalizations.of(context)!.forgot_password,
                                      style: const TextStyle(
                                        fontFamily: 'Candara',
                                        color: blueClr,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.23,
                            ),
                            ButtonWidget(
                                text: AppLocalizations.of(context)!.login,
                                onPressed: () => signIn(_emailController.text,
                                    _passwordController.text)),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup_screen');
                              },
                              child:  Text(
                                AppLocalizations.of(context)!.you_dont_have_an_account_signup,
                                style: const TextStyle(
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
            ],
          ),
        ),
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
        Navigator.pushReplacementNamed(context, '/button_navigator_bar');

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showSnackBar(context, message: AppLocalizations.of(context)!.user_not_found, error: true);
        } else if (e.code == 'wrong-password') {
          showSnackBar(context, message: AppLocalizations.of(context)!.wrong_password, error: true);
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

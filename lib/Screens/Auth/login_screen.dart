import 'package:flutter/material.dart';
import 'package:medical_assistant/Screens/Auth/sginup_screen.dart';
import '../../widgets/ButtonClick.dart';
import '../../widgets/circleLoginAs.dart';
import '../../widgets/textFiledWidget.dart';
import '../../widgets/textTitleWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController IdtextEditingController=TextEditingController();
  TextEditingController PasswordtextEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[50],
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 45,
            ),
            const TextTitleWidget(title: "Sgin In"),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                circleLoginAs(text: 'U'),
                circleLoginAs(text: 'D'),
                circleLoginAs(text: 'E'),
              ],
            ),
            TextFieldWidget(
                hintTextField: 'Enter Your Id number',
                prefixIcon: Icons.perm_identity,
                suffixIcon: Icons.circle,
                suffixIconSize: 12,
                color: Colors.red.withOpacity(0.89),
              textEditingController: IdtextEditingController,

            ),
            TextFieldWidget(
                hintTextField: 'Enter your Password',
                prefixIcon: Icons.password,
                suffixIcon: Icons.visibility_off,
                suffixIconSize: 25,
                color: Colors.purple.withOpacity(0.89),
                obscureText: true,
            textEditingController: PasswordtextEditingController,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "forget your password?",
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
             ButtonClick(text: "LOGIN AS USER",IdtextEditingController: IdtextEditingController,PasswordtextEditingController: PasswordtextEditingController),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (c) => SginUpScreen()));
              },
              child: const Text(
                "You don't have any account?",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "-OR-",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade500,
                        shadows: [
                          const Shadow(
                              offset: Offset(2, 2),
                              color: Colors.black38,
                              blurRadius: 10),
                          Shadow(
                              offset: const Offset(-2, -2),
                              color: Colors.white.withOpacity(0.85),
                              blurRadius: 10)
                        ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                          boxShadow: [
                            const BoxShadow(
                                offset: Offset(10, 10),
                                color: Colors.black38,
                                blurRadius: 20),
                            BoxShadow(
                                offset: const Offset(-10, -10),
                                color: Colors.white.withOpacity(0.85),
                                blurRadius: 10)
                          ]),
                      child: Icon(
                        Icons.fingerprint_sharp,
                        size: 50,
                        color: Colors.purple.shade500,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

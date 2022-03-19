import 'package:flutter/material.dart';

import '../../widgets/ButtonClick.dart';
import '../../widgets/textFiledWidget.dart';
import '../../widgets/textTitleWidget.dart';
class ChangePassword_Screen extends StatelessWidget {
  const ChangePassword_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey[50],
        body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 20),
    child: ListView(
    children: [
     const SizedBox(
    height: 45,
    ),
     const TextTitleWidget(title: "Password recovery"),
     const SizedBox(height: 30,),
      const Center(child:   Text("Please, Setup A New Password\n                 Your Account",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
     const SizedBox(height: 20,),
      TextFieldWidget(
        typeKey: TextInputType.visiblePassword,
        hintTextField: 'Enter New Password',
        prefixIcon: Icons.password,
        suffixIcon: Icons.visibility_off,
        suffixIconSize: 25,
        color: Colors.purple.withOpacity(0.89),
        obscureText: true,
        // textEditingController: PasswordtextEditingController,
      ),
      TextFieldWidget(
        typeKey: TextInputType.visiblePassword,
        hintTextField: 'Repeat Password',
        prefixIcon: Icons.password,
        suffixIcon: Icons.visibility_off,
        suffixIconSize: 25,
        color: Colors.purple.withOpacity(0.89),
        obscureText: true,
        // textEditingController: PasswordtextEditingController,
      ),
      const SizedBox(height: 50,),
     const ButtonClick(text: "Save Password"),
    ])));
  }
}

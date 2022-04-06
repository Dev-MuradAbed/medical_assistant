import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_assistant/them.dart';
import 'package:medical_assistant/widget/text_field.dart';

import '../widget/button_widget.dart';

class SignupScreen extends StatefulWidget {

  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _Sginup_ScreenState();

}


class _Sginup_ScreenState extends State<SignupScreen> {
  late TextEditingController _idController;

  @override
  void initState() {
    // TODO: implement initState
    _idController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _idController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
                title: const Text(
        'SGIN UP',
        style: TextStyle(
          fontFamily: 'Candara',
          color: Color(0xff184093),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(

            children: [
              const SizedBox(height: 10,),
               TextInput(label: 'User ID', controller: _idController, keyboardType: TextInputType.number),
               const SizedBox(height: 35,),
               TextInput(label: 'User Name', controller: _idController, keyboardType: TextInputType.number),
              const SizedBox(height: 35,),

              TextInput(label: 'Birthday', controller: _idController, keyboardType: TextInputType.number),
              const SizedBox(height: 35,),

              TextInput(label: 'Phone Number', controller: _idController, keyboardType: TextInputType.number),
              const SizedBox(height: 35,),

              TextInput(label: 'Other Phone', controller: _idController, keyboardType: TextInputType.number),
              const SizedBox(height: 35,),

              TextInput(label: 'Gender', controller: _idController, keyboardType: TextInputType.number),
              const SizedBox(height: 35,),

              TextInput(label: 'Height', controller: _idController, keyboardType: TextInputType.number),
              const SizedBox(height: 35,),

              TextInput(label: 'Weight', controller: _idController, keyboardType: TextInputType.number),
              const SizedBox(height: 35,),

              TextInput(label: 'Password', controller: _idController, keyboardType: TextInputType.number),
              const SizedBox(height: 35,),

              TextInput(label: 'confirm Password', controller: _idController, keyboardType: TextInputType.number),
              const SizedBox(height: 35,),
              ButtonWidget(text: "Create", onPressed: (){}),
              const SizedBox(height: 35,),


            ],
          ),
        ),
      ),
    );
  }
}

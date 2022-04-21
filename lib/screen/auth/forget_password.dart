import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



import '../../theme.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_field.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  String verificationIdReceieved='';
  @override
  void initState() {
    super.initState();
    _emailController=TextEditingController();
    _phoneController=TextEditingController();
  }
  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: blueClr,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Forget Password',style:
          TextStyle(
            color: blueClr,
            fontSize: 25,
            fontFamily: 'Candara',
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: Column(
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
            const Text('Enter your email to recover your password',
              style: TextStyle(
                fontFamily: 'Candara',
                color: blackClr,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 15),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),

              child: TextInput(
                controller: _emailController,
                label: 'Enter Email',
                keyboardType: TextInputType.emailAddress,
                widgetIcon: const Icon(
                  Icons.email,
                  color: greenClr,
                  size: 22,
                ),
                validator: (value) {
                  if (value!.length == 0) {
                    return "Email cannot be empty";
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
            ),
            const SizedBox(height: 30),
            ButtonWidget(text: 'Sent', onPressed: () {
              _sendPasswordResetEmail(_emailController.text);
            }),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
  void _sendPasswordResetEmail(String email)async{
    if(_formkey.currentState!.validate()){
      await _auth.sendPasswordResetEmail(email: email).then((value) =>{
        Navigator.pushNamed(context, '/forget_screen')
      }).catchError((e){
        print(e);
      });
    }
  }

}

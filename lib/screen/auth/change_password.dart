

import 'package:flutter/material.dart';




import '../../theme.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;
  @override
  void initState() {
    // TODO: implement initState
    _newPasswordController=TextEditingController();
    _confirmNewPasswordController=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: blueClr,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "New Password",
          style: TextStyle(
            color: blueClr,
            fontSize: 25,
            fontFamily: 'Candara',
            fontWeight: FontWeight.bold,
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(top: 95),
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
                const Text(
                  'Please, setup your new password for \n   your account',
                  style: TextStyle(
                    fontFamily: 'Candara',
                    color: blackClr,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'dev*****ed@gmail.com',
                  style: TextStyle(
                    fontFamily: 'Candara',
                    color: blackClr,
                    letterSpacing: 1.2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                TextInput(label: "New Password", controller: _newPasswordController),
                const SizedBox(height: 25),
                TextInput(label: "Confirm Password", controller: _confirmNewPasswordController),
                const SizedBox(height: 30),
                const SizedBox(height: 50),
                ButtonWidget(text: 'Save', onPressed: () {}),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

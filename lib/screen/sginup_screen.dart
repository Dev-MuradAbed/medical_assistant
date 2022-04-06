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


   String _selectGender = 'Meal';

  // List of items in our dropdown menu
  List genderList = [
    'Meal',
    'Female',
  ];
  late TextEditingController _idController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;
  late TextEditingController nameController;
  late TextEditingController birthController;
  late TextEditingController phoneController;
  late TextEditingController otherPhoneController;
  late TextEditingController emailController;
  late TextEditingController genderController;
  late TextEditingController heightController;
  late TextEditingController weightController;

  @override
  void initState() {
    // TODO: implement initState
    _idController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    otherPhoneController = TextEditingController();
    nameController = TextEditingController();
    birthController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    genderController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordConfirmController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    otherPhoneController.dispose();
    nameController.dispose();
    birthController.dispose();
    phoneController.dispose();
    emailController.dispose();
    genderController.dispose();
    heightController.dispose();
    weightController.dispose();
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: blueClr,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'SIGN UP',
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
              const SizedBox(
                height: 10,
              ),
              TextInput(
                  label: 'User ID',
                  controller: _idController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 35),
              TextInput(
                  label: 'User Name',
                  controller: nameController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 35),
              TextInput(
                label: 'Birthday',
                controller: birthController,
                keyboardType: TextInputType.none,
                onTap: () async => _getDate(),
              ),
              // TextFormField(
              //   controller: birthController,
              //   decoration: const InputDecoration(
              //     labelText: "Date of birth",
              //     hintText: "Ex. Insert your dob",
              //   ),
              //   onTap: () async {
              //     await _getDate(context);
              //   },
              // ),
              const SizedBox(height: 35),
              TextInput(
                  label: 'Phone Number',
                  controller: phoneController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 35),
              TextInput(
                  label: 'Other Phone',
                  controller: otherPhoneController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 35),
              Row(
                children: [
                  Expanded(
                    child: TextInput(
                        label: 'Gender',
                        controller: genderController,
                        keyboardType: TextInputType.number,
                    widgetIcon:  DropdownButton(
                      underline: Container(height: 0),
                      borderRadius: BorderRadius.circular(10),
                      elevation: 4,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.grey,
                      ),
                      iconSize: 30,
                      items: genderList.map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text('$value'))).toList(),
                      onChanged: (String? newvalue) {
                        setState(() {
                          _selectGender =(newvalue!);
                        });
                      },
                    ),

                    ),
                  ),

                ],
              ),
              const SizedBox(height: 35),
              TextInput(
                  label: 'Height',
                  controller: heightController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 35),
              TextInput(
                  label: 'Weight',
                  controller: weightController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 35),
              TextInput(
                  label: 'Password',
                  controller: _passwordController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 35),
              TextInput(
                  label: 'confirm Password',
                  controller: _passwordConfirmController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 35),
              ButtonWidget(text: "Create", onPressed: () {}),
              const SizedBox(height: 35),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getDate() async {
    DateTime date = DateTime(1900);
    FocusScope.of(context).requestFocus(FocusNode());
    date = (await showDatePicker(
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData(
                primarySwatch: Colors.grey,
                splashColor: Colors.black,
                textTheme: const TextTheme(
                  subtitle1: TextStyle(color: Colors.black),
                  button: TextStyle(color: Colors.black),
                ),
                colorScheme: const ColorScheme.light(
                  primary: greenClr,
                  secondary: blueClr,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child ?? Text(""),
            );
          },
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        )) ??
        DateTime.now();
    setState(() {
      birthController.text = '${date.day}/${date.month}/${date.year}';
    });
  }
}

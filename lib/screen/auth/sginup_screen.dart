import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_assistant/utils/helpers.dart';
import '../../database/storage_fire.dart';
import '../../theme.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
class _SignupScreenState extends State<SignupScreen> with Helper {
  String _selectGender = 'Meal';
  bool isPassword = true;
  final Storage storage = Storage();
  final ValueNotifier<String> _imageUrl = ValueNotifier('assets/images/logo_png.png');
  List genderList = [
    'Meal',
    'Female',
  ];
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
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
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
    _passwordConfirmController.dispose();
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
        title:  Text(
          AppLocalizations.of(context)!.signup,
          style: const TextStyle(
            fontFamily: 'Candara',
            color: Color(0xff184093),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 2),
              ValueListenableBuilder(
                  valueListenable: _imageUrl,
                  builder: (context, value, child) {
                    return Container(
                      height: 100,
                      width: 100,
                      child: IconButton(
                        onPressed: () async {
                          final result = await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'png', 'jpeg'],
                          );
                          if (result == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                    content: Text( AppLocalizations.of(context)!.no_file_selected)));
                            return;
                          }
                          final path = result.files.single.path!;
                          final filename = result.files.single.name;
                          storage.uploadImage(path, filename);
                          _imageUrl.value = await storage.getImage(filename);
                          setState(() {
                            print(value.toString());
                          });
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          size: 36,
                          color: blueClr,
                        ),
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(value.toString()),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: greenClr, width: 2),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
              const SizedBox(height: 20),
              const SizedBox(height: 30),
              TextInput(
                label: AppLocalizations.of(context)!.user_name,
                controller: nameController,
              ),
              const SizedBox(height: 30),
              TextInput(
                label: AppLocalizations.of(context)!.email,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),
              TextInput(
                label: AppLocalizations.of(context)!.birthday,
                readOnly: true,
                controller: birthController,
                onTap: () async => _getDate(),
              ),
              const SizedBox(height: 30),
              TextInput(
                  label: AppLocalizations.of(context)!.phone,
                  controller: phoneController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 30),
              TextInput(
                  label: AppLocalizations.of(context)!.other_phone,
                  controller: otherPhoneController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 30),
              TextInput(
                onTap: () async {
                  setState(() {
                    genderController.text = _selectGender;
                  });
                },
                label: AppLocalizations.of(context)!.gender,
                readOnly: true,
                controller: genderController,
                sufWidget: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 20),
                  child: DropdownButton(
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
                    items: genderList
                        .map<DropdownMenuItem<String>>((value) =>
                            DropdownMenuItem<String>(
                                value: value.toString(), child: Text('$value')))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectGender = (newValue!);
                        genderController.text = _selectGender;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextInput(
                  label: AppLocalizations.of(context)!.height,
                  controller: heightController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 30),
              TextInput(
                  label: AppLocalizations.of(context)!.weight,
                  controller: weightController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 30),
              TextInput(
                label: AppLocalizations.of(context)!.entre_password,
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
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
                    return AppLocalizations.of(context)!.password_can_not_be_empty;
                  }
                  if (!regex.hasMatch(value)) {
                    return (AppLocalizations.of(context)!.password_must_be_at_least_6_characters);
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _passwordController.text = value!;
                },
              ),
              const SizedBox(height: 30),
              TextInput(
                // label: 'password',
                label: AppLocalizations.of(context)!.confirm_password,
                controller: _passwordConfirmController,
                keyboardType: TextInputType.emailAddress,
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
                    return AppLocalizations.of(context)!.password_can_not_be_empty;
                  }
                  if (!regex.hasMatch(value)) {
                    return (AppLocalizations.of(context)!.password_must_be_at_least_6_characters);
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _passwordController.text = value!;
                },
              ),
              const SizedBox(height: 30),
              ButtonWidget(text: AppLocalizations.of(context)!.create, onPressed:  perSingUp),
              const SizedBox(height: 30),
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
              child: child ?? const Text(""),
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

   perSingUp()  {
    print("perSingUp");
    if ( checkSignup()) {
      singUp();
    }
  }

   checkSignup()  {
    if (nameController.text.isNotEmpty &&
        birthController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        heightController.text.isNotEmpty &&
        weightController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _passwordConfirmController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        otherPhoneController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        emailController.text.contains('@') &&
        emailController.text.contains('.') &&
        _passwordController.text.length >= 6 &&
        _passwordConfirmController.text.length >= 6 &&
        _passwordController.text == _passwordConfirmController.text) {
      try {
        _firebaseAuth.createUserWithEmailAndPassword(email: emailController.text, password: _passwordController.text).then((value) async {
          await FirebaseFirestore.instance.collection('UserUid').doc('123963').set({'id': value.user!.uid});
          // FirebaseFirestore.instance.collection('UserData').doc(FirebaseAuth.instance.currentUser!.uid).collection("DoctorNote").doc();
          await FirebaseFirestore.instance.collection("UserData").doc(value.user!.uid).set({
            'image': _imageUrl.value,
            'name': nameController.text,
            'birth': birthController,
            'email': emailController.text,
            'gender': genderController.text,
            'phone': phoneController.text,
            'otherPhone': otherPhoneController.text,
            'height': heightController.text,
            'weight': weightController.text,
            'role': 'user',
          });
        });
        return true;
      } on FirebaseAuthException catch (e) {
        showSnackBar(context, message: e.code, error: true);
      }
    }
    if (nameController.text.isEmpty) {
      showSnackBar(context,
          message: AppLocalizations.of(context)!.please_enter_your_username, error: true);
    } else if (emailController.text.isEmpty) {
      showSnackBar(context, message: AppLocalizations.of(context)!.please_enter_your_email, error: true);
    } else if (!emailController.text.contains('@') ||
        !emailController.text.contains('.')) {
      showSnackBar(context, message: AppLocalizations.of(context)!.email_is_not_valid, error: true);
    } else if (birthController.text.isEmpty) {
      showSnackBar(context, message: AppLocalizations.of(context)!.please_enter_your_birthday, error: true);
    } else if (phoneController.text.isEmpty) {
      showSnackBar(context, message: AppLocalizations.of(context)!.please_enter_your_phone, error: true);
    } else if (otherPhoneController.text.isEmpty) {
      showSnackBar(context,
          message: AppLocalizations.of(context)!.please_enter_your_other_phone, error: true);
    } else if (genderController.text.isEmpty) {
      showSnackBar(context, message: AppLocalizations.of(context)!.please_enter_your_gender, error: true);
    } else if (heightController.text.isEmpty) {
      showSnackBar(context, message: AppLocalizations.of(context)!.please_enter_your_height, error: true);
    } else if (weightController.text.isEmpty) {
      showSnackBar(context, message: AppLocalizations.of(context)!.please_enter_your_weight, error: true);
    } else if (_passwordController.text.length < 6 ||
        _passwordConfirmController.text.length < 6) {
      showSnackBar(context,
          message: AppLocalizations.of(context)!.password_must_be_at_least_6_characters, error: true);
    } else if (_passwordController.text != _passwordConfirmController.text) {
      showSnackBar(context, message: AppLocalizations.of(context)!.password_does_not_match, error: true);
    }else{
      showSnackBar(context, message: AppLocalizations.of(context)!.email_is_already_exist, error: true);
    }
    return false;
  }
  singUp() {
    Navigator.pushReplacementNamed(context, '/button_navigator_bar');
  }
}
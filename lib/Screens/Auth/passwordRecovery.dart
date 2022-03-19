import 'package:flutter/material.dart';
import 'package:medical_assistant/Screens/Auth/sginup_screen.dart';
import '../../widgets/ButtonClick.dart';
import '../../widgets/circleLoginAs.dart';
import '../../widgets/textFiledWidget.dart';
import '../../widgets/textTitleWidget.dart';
import '../../widgets/verificationWidget.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({Key? key}) : super(key: key);

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
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
            const  Center(child:  Text("Enter 4 Number Code sent You\n      On Your Phone Number",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              const SizedBox(height: 20,),
             const Center(child:  Text("+972*****28",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  VerificationWidget(first: true,last: false,),
                  VerificationWidget(first: false,last: false,),
                  VerificationWidget(first: false,last: false,),
                  VerificationWidget(first: false,last: true,),

                  // circleLoginAs(text: '1'),
                  // circleLoginAs(text: '2'),
                  // circleLoginAs(text: '3'),
                  // circleLoginAs(text: '4'),
                ],
              ),


const SizedBox(height: 40,),
             const ButtonClick(text: "verification"),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ));

  }
}

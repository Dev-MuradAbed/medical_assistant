import 'package:flutter/material.dart';
import 'package:medical_assistant/widgets/profileWidget.dart';

import '../../widgets/ButtonClick.dart';
import '../../widgets/textFiledWidget.dart';
import '../../widgets/textTitleWidget.dart';
class Profile_Patient extends StatelessWidget {
  const Profile_Patient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(iconTheme: IconThemeData(color: Colors.purple.withOpacity(0.89),size: 30),
        title: const TextTitleWidget(title: "Profile"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[50],
      ),
      body: ListView(
        children: [
          ProfileWidget(onClicked: () {  }, imagePath: 'https://avatars.githubusercontent.com/u/93073520?v=4',),
          const TextFieldWidget(
            hintTextField: '405840174',
            prefixIcon: Icons.badge,
            // suffixIcon: Icons.circle,
            // suffixIconSize: 12,
          ),
          const TextFieldWidget(
            hintTextField: 'Murad Abed',
            prefixIcon: Icons.perm_identity,
            // suffixIcon: Icons.circle,
            // suffixIconSize: 12,
          ),
          const TextFieldWidget(
            hintTextField: '12/4/2000',
            prefixIcon: Icons.calendar_month,
            // suffixIcon: Icons.circle,
            // suffixIconSize: 12,
          ),
          const TextFieldWidget(
            hintTextField: '0599084404',
            prefixIcon: Icons.phone_callback_rounded,
            suffixIcon:
              Icons.edit,
              color: Colors.purple,


            // suffixIconSize: 12,
          ),
          const TextFieldWidget(
            hintTextField: '0599084404',
            prefixIcon: Icons.phone_forwarded_rounded,
            suffixIcon:               Icons.edit,
            color: Colors.purple,
            // suffixIconSize: 12,
          ),
          const TextFieldWidget(
            hintTextField: 'Meal',
            prefixIcon: Icons.man,
            // suffixIcon: Icons.circle,
            // suffixIconSize: 12,
          ),
          const TextFieldWidget(
            hintTextField: '187',
            prefixIcon: Icons.straighten_outlined,
             suffixIcon:               Icons.edit,
                         color: Colors.purple,
            // suffixIconSize: 12,
          ),
          const TextFieldWidget(
            hintTextField: '70',
            prefixIcon: Icons.monitor_weight_outlined,
            suffixIcon:               Icons.edit,
            color: Colors.purple,
            // suffixIconSize: 12,
          ),
           const ButtonClick(text: 'Save Change'),
        ],
      ),
    );
  }
}

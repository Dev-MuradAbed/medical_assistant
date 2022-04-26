import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../theme.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_field.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String birthFirebase='';
  // ='4/12/2000';
  String EmailFirebase='';
  // ='dev******@gmail.com';
  String genderFirebase='';
  // ='Male';
  String heightFirebase='';
  // ='185';
  String idCardFirebase='';
  // ='405840174';
  String nameFirebase='';
  // ='User Name';
  String OtherPhoneFirebase='';
  // ='0599084404';
  String PhoneFirebase='';
  // ='0599084404';
  String WeightFirebase='';
  // ='70';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: SingleChildScrollView(
          child: FutureBuilder(
    future: _fetch(),
    builder: (context,snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return Column(
          children: [
            const SizedBox(height: 2),
            Container(
              height: 150,
              width: 150,
              child: Stack(
                  children: [
                    Image.asset('assets/images/woman.png'),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: greenClr, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 24,
                          color: greenClr,
                        ),
                      ),
                    )
                  ]),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: greenClr, width: 2),
                //color: greenClr,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 30),
            TextInput(
              readOnly: true,
                label: 'User ID',
                hint: idCardFirebase,
                keyboardType: TextInputType.number),
            const SizedBox(height: 30),
            TextInput(
              readOnly: true,
              label: 'User Name',
              hint: nameFirebase,
              // sufWidget: IconButton(
              //   icon: (
              //       Icon(Icons.edit)),
              //   // onPressed: ()=>_updateProfile(),
              // ),
            ),
            const SizedBox(height: 30),
            TextInput(
              label: 'Birthday',
              readOnly: true,
              hint: birthFirebase,
            ),
            const SizedBox(height: 30),
            TextInput(
              readOnly: true,
                label: 'Phone Number',
                hint: PhoneFirebase,
                keyboardType: TextInputType.number),
            const SizedBox(height: 30),
            TextInput(
                label: 'Other Phone',
                hint: OtherPhoneFirebase,
                readOnly: true,
                keyboardType: TextInputType.number

            ),
            const SizedBox(height: 30),
            TextInput(label: 'Gender', readOnly: true, hint: genderFirebase
              //  controller: genderController,

            ),
            const SizedBox(height: 30),
            TextInput(
                label: 'Height',
                hint: heightFirebase,
                readOnly: true,
                keyboardType: TextInputType.number),
            const SizedBox(height: 30),
            TextInput(
                label: 'Weight',
                hint: WeightFirebase,
                //controller: weightController,
                keyboardType: TextInputType.number),
            const SizedBox(height: 25),
            ButtonWidget(text: "Edit Profile", onPressed: () {}),
            const SizedBox(height: 30),
          ],
        );
      }
      return Center(child: CircularProgressIndicator());
      // },
      //         child: Column(
      //           children: [
      //             const SizedBox(height: 2),
      //             Container(
      //              // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      //               height: 150,
      //               width: 150,
      //               child: Stack(
      //                   children: [
      //                 Image.asset('assets/images/woman.png'),
      //                 Align(
      //                   alignment: Alignment.bottomRight,
      //                   child: Container(
      //                     padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      //                     decoration: BoxDecoration(
      //                       color: Colors.white,
      //                       shape: BoxShape.circle,
      //                       border: Border.all(color: greenClr, width: 2),
      //                     ),
      //                     child: const Icon(
      //                       Icons.camera_alt_outlined,
      //                       size: 24,
      //                       color: greenClr,
      //                     ),
      //                   ),
      //                 )
      //               ]),
      //               alignment: Alignment.center,
      //               decoration: BoxDecoration(
      //                 //borderRadius: BorderRadius.all(Radius.circular(10)),
      //                 border: Border.all(color: greenClr, width: 2),
      //                 //color: greenClr,
      //                 shape: BoxShape.circle,
      //               ),
      //             ),
      //             const SizedBox(height: 30),
      //             TextInput(
      //
      //                 label: '$EmailFirebase',
      //                 //controller: _idController,
      //                 hint: '489354785462',
      //                 keyboardType: TextInputType.number),
      //             const SizedBox(height: 30),
      //             TextInput(
      //               label: 'User Name',
      //               hint: 'Julia',
      //               //controller: nameController,
      //             ),
      //             const SizedBox(height: 30),
      //             TextInput(
      //               label: 'Birthday',
      //               readOnly: true,
      //               hint: '15/9/1999',
      //               //controller: birthController,
      //               // onTap: () async => _getDate(),
      //             ),
      //             const SizedBox(height: 30),
      //             TextInput(
      //                 label: 'Phone Number',
      //                 hint: '0599748528',
      //                 //    controller: phoneController,
      //                 keyboardType: TextInputType.number),
      //             const SizedBox(height: 30),
      //             TextInput(
      //                 label: 'Other Phone',
      //                 hint: '0599481245',
      //                 // controller: otherPhoneController,
      //                 keyboardType: TextInputType.number),
      //             const SizedBox(height: 30),
      //             TextInput(label: 'Gender', readOnly: true, hint: 'female'
      //                 //  controller: genderController,
      //
      //                 ),
      //             const SizedBox(height: 30),
      //             TextInput(
      //                 label: 'Height',
      //                 hint: '165',
      //                 //controller: heightController,
      //                 keyboardType: TextInputType.number),
      //             const SizedBox(height: 30),
      //             TextInput(
      //                 label: 'Weight',
      //                 hint: '55',
      //                 //controller: weightController,
      //                 keyboardType: TextInputType.number),
      //             const SizedBox(height: 25),
      //             ButtonWidget(text: "Edit Profile", onPressed: () {}),
      //             const SizedBox(height: 30),
      //           ],
      //         ),
    }
      ),
      ),
        ),

    );
  }
  // _updateProfile()async{
  //   final firebaseUser =  FirebaseAuth.instance.currentUser;
  //   if(firebaseUser!=null) {
  //    await   FirebaseFirestore.instance.collection('UserData').
  //     doc(firebaseUser.uid).update(
  //      {
  //        'idCard':'',
  //        'name':'Murad2000',
  //        'birth':'',
  //        'email':'',
  //        'gender':'',
  //        'height':'',
  //        'otherPhone':'',
  //        'phone':'',
  //        'weight':'',
  //      }
  //    );
  //   }
  // }
_fetch()async{
    final firebaseUser =  FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null){
      await FirebaseFirestore.instance.collection('UserData').
  doc(FirebaseAuth.instance.currentUser!.uid).get().then((ds){
    print(ds.data()!['name']);
    idCardFirebase=ds.data()!['idCard'];
    nameFirebase=ds.data()!['name'];
      birthFirebase =ds.data()!['birth'];
      EmailFirebase =ds.data()!['email'];
      genderFirebase =ds.data()!['gender'];
      heightFirebase =ds.data()!['height'];
      OtherPhoneFirebase =ds.data()!['otherPhone'];
      PhoneFirebase =ds.data()!['phone'];
      WeightFirebase =ds.data()!['weight'];
      // if(ds.data()!['role']=='admain'){
      //   return print('User');
      // }else{
      //   return print('else');
      // }


  print(EmailFirebase);
      }).catchError((e){
        print(e);
      });
    }
}

}

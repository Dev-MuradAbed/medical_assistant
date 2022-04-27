import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_assistant/database/storage_fire.dart';
import 'package:medical_assistant/models/profile_model.dart';
import 'package:medical_assistant/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Storage storage = Storage();
  final ValueNotifier<String> _imageUrl = ValueNotifier('https://avatars.githubusercontent.com/u/93073520?s=400&u=8b466ff9fe1b27a7d4ff441f84b2289484422a76&v=4');
  bool visible = false;
  bool readonly = true;
  late TextEditingController phoneController;
  late TextEditingController otherPhoneController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  String image='https://avatars.githubusercontent.com/u/93073520?s=400&u=8b466ff9fe1b27a7d4ff441f84b2289484422a76&v=4';
  @override
  void initState() {
    // TODO: implement initState
    otherPhoneController = TextEditingController();
    phoneController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
    Provider.of<ProfileProvider>(context, listen: false).getTask();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    otherPhoneController.dispose();
    phoneController.dispose();
    heightController.dispose();
    weightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: _fetch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return FutureProvider(
                      initialData: [],
                      create: (context) =>
                          Provider.of<ProfileProvider>(context, listen: false)
                              .getTask(),
                      child: Consumer<ProfileProvider>(
                        builder: (context, task, child) {
                          return Builder(builder: (context) {
                            var profile =
                                Provider.of<ProfileProvider>(context).listTask;
                            // print(profile.image.toString());
                            return Column(
                              children: [
                                const SizedBox(height: 2),
                                Builder(builder: (context) {
                                  return ValueListenableBuilder(
                                    valueListenable: _imageUrl,
                                    builder: (context,value,child){
                                      return Container(
                                        height: 150,
                                        width: 150,
                                        child: Stack(children: [
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Visibility(
                                              visible: visible,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: greenClr, width: 2),
                                                ),



                                                child: IconButton(
                                                  onPressed: () async {
                                                    final result = await FilePicker.platform.pickFiles(
                                                      allowMultiple: false,
                                                      type: FileType.custom,
                                                      allowedExtensions: ['jpg', 'png', 'jpeg'],
                                                    );
                                                    if (result == null) {
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                          const SnackBar(
                                                              content: Text('No filere Selected')));
                                                      return null;
                                                    }
                                                    final path = result.files.single.path!;
                                                    final filename = result.files.single.name;
                                                    storage.uploadImage(path, filename);
                                                    _imageUrl.value=await storage.getImage(filename) ;
                                                    setState(() {
                                                      image=_imageUrl.value;
                                                    });




                                                  },
                                                  icon: const Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: 24,
                                                    color: greenClr,
                                                  ),
                                                ),

                                              ),
                                            ),
                                          )
                                        ]),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              profile[0].image ??
                                                  'https://avatars.githubusercontent.com/u/93073520?v=4',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          border:
                                          Border.all(color: greenClr, width: 2),
                                          //color: greenClr,
                                          shape: BoxShape.circle,
                                        ),
                                      );
                                    },

                                  );
                                }),
                                const SizedBox(height: 30),
                                TextInput(
                                    readOnly: true,
                                    label: 'User ID',
                                    hint: profile[0].id.toString(),
                                    keyboardType: TextInputType.number),
                                const SizedBox(height: 30),
                                TextInput(
                                  readOnly: true,
                                  label: 'User Name',
                                  hint: profile[0].name,
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
                                  hint: profile[0].birthday,
                                ),
                                const SizedBox(height: 30),
                                TextInput(
                                  controller: phoneController,
                                  readOnly: !visible,
                                  label: 'Phone Number',
                                  hint: profile[0].phone ,
                                  keyboardType: TextInputType.number,
                                  sufWidget: Visibility(
                                    visible: visible,
                                    child: IconButton(
                                      icon: (Icon(Icons.edit)),
                                      onPressed: () {
                                         phoneController.text=profile[0].phone.toString();
                                      },
                                      // onPressed: ()=>_updateProfile(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextInput(
                                  controller: otherPhoneController,
                                  label: 'Other Phone',
                                  hint:  profile[0].other,
                                  readOnly: !visible,
                                  keyboardType: TextInputType.number,
                                  sufWidget: Visibility(
                                    visible: visible,
                                    child: IconButton(
                                      icon: (Icon(Icons.edit)),
                                      onPressed: () {
                                        setState(() {
                                          otherPhoneController.text=profile[0].other.toString();
                                        });
                                      },
                                      // onPressed: ()=>_updateProfile(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextInput(
                                    label: 'Gender',
                                    readOnly: true,
                                    hint: profile[0].gender
                                    //  controller: genderController,
//error
                                    ),
                                const SizedBox(height: 30),
                                TextInput(
                                  controller: heightController,
                                  label: 'Height',
                                  hint:  profile[0].height,
                                  readOnly: !visible,
                                  keyboardType: TextInputType.number,
                                  sufWidget: Visibility(
                                    visible: visible,
                                    child: IconButton(
                                      icon: (Icon(Icons.edit)),
                                      onPressed: () {
                                        profile[0].other.toString();
                                      },
                                      // onPressed: ()=>_updateProfile(),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 30),
                                TextInput(
                                  controller: weightController,
                                  label: 'Weight',
                                  hint:  profile[0].height,
                                  readOnly: !visible,
                                  keyboardType: TextInputType.number,
                                  sufWidget: Visibility(
                                    visible: visible,
                                    child: IconButton(
                                      icon: (Icon(Icons.edit)),
                                      onPressed: () {
                                        profile[0].wight.toString();
                                      },
                                      // onPressed: ()=>_updateProfile(),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 25),
                                ButtonWidget(
                                    text: visible == false
                                        ? "Edit Profile"
                                        : "Save",
                                    onPressed: () {
                                      setState(() {
                                        _updateProfile(height: heightController.text, otherPhone: otherPhoneController.text, phone: phoneController.text, weight: weightController.text,image:
                                        image);
                                        visible = !visible;
                                      });

                                      // FirebaseAuth.instance.signOut();
                                    }),
                                const SizedBox(height: 60),
                              ],
                            );
                          });
                        },
                      ));
                }
                return const Center(child: const CircularProgressIndicator());
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
              }),
        ),
      ),
    );
  }

  _updateProfile(
      {required String height,required String otherPhone,required String phone,required String weight,required String image}) async {
    print('update profile');
    print('h $height');
    print('h$otherPhone');
    print('p$phone');
    print('p$image');
    print('p$image');
    print(weight);
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('UserData')
          .doc(firebaseUser.uid)
          .update({
        'height': height,
        'otherPhone': otherPhone,
        'phone': phone,
        'weight': weight,
        'image':image
      });
    }
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      print(FirebaseAuth.instance.currentUser!.uid);
      await FirebaseFirestore.instance
          .collection('UserData')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((ds) async {
        try {
          await Provider.of<ProfileProvider>(context, listen: false).addTask(
              task: Profile(
            id: ds.data()!['idCard'],
            name: ds.data()!['name'],
            type: ds.data()!['type'],
            height: ds.data()!['height'],
            email: ds.data()!['email'],
            birthday: ds.data()!['birth'],
            gender: ds.data()!['gender'],
            image: ds.data()!['image'],
            other: ds.data()!['otherPhone'],
            phone: ds.data()!['phone'],
            wight: ds.data()!['weight'],
          ));
        } catch (e) {
          print(e);
        }
      }).catchError((e) {
        print(e);
      });
    }
  }
}
// final firebaseUser = FirebaseAuth.instance.currentUser;
// if (firebaseUser != null) {
//   print(FirebaseAuth.instance.currentUser!.uid);
//   await FirebaseFirestore.instance
//       .collection('UserData')
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .get()
//       .then((ds) {
//     print(ds.data()!['name']);
//     idCardFirebase = ds.data()!['idCard'];
//     nameFirebase = ds.data()!['name'];
//     birthFirebase = ds.data()!['birth'];
//     EmailFirebase = ds.data()!['email'];
//     genderFirebase = ds.data()!['gender'];
//     heightFirebase = ds.data()!['height'];
//     OtherPhoneFirebase = ds.data()!['otherPhone'];
//     PhoneFirebase = ds.data()!['phone'];
//     WeightFirebase = ds.data()!['weight'];
//     // if(ds.data()!['role']=='admain'){
//     //   return print('User');
//     // }else{
//     //   return print('else');
//     // }
//
//     print(EmailFirebase);

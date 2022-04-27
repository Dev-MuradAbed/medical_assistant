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
  bool visible = false;
String _imageUrl='';
  String birthFirebase = '';
  // ='4/12/2000';
  String EmailFirebase = '';
  // ='dev******@gmail.com';
  String genderFirebase = '';
  // ='Male';
  String heightFirebase = '';
  // ='185';
  String idCardFirebase = '';
  // ='405840174';
  String nameFirebase = '';
  // ='User Name';
  String OtherPhoneFirebase = '';
  // ='0599084404';
  String PhoneFirebase = '';
  // ='0599084404';
  String WeightFirebase = '';
  // ='70';
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProfileProvider>(context,listen: false).getTask();
    super.initState();
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
                    create:(context)=> Provider.of<ProfileProvider>(context, listen: false).getTask(),
                    child: Consumer<ProfileProvider>(
                      builder: (context,task,child){

                            return Builder(builder: (context){

                              var profile =
                              Provider.of<ProfileProvider>(context).listTask;
                              // print(profile.image.toString());
                              return
                               Column(
                                children: [
                                  const SizedBox(height: 2),
                                  Builder(builder: (context) {
                                    return Container(
                                      height: 150,
                                      width: 150,

                                      child: Stack(children: [
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
                                            child: IconButton(
                                              onPressed: (){

                                              },
                                              // onPressed: () async {
                                              //   final result =
                                              //   await FilePicker.platform.pickFiles(
                                              //     allowMultiple: false,
                                              //     type: FileType.custom,
                                              //     allowedExtensions: ['jpg', 'png', 'jpeg'],
                                              //   );
                                              //   if (result == null) {
                                              //     ScaffoldMessenger.of(context)
                                              //         .showSnackBar(const SnackBar(
                                              //         content:
                                              //         Text('No filere Selected')));
                                              //     return null;
                                              //   }
                                              //   final path = result.files.single.path!;
                                              //   final filename = result.files.single.name;
                                              //   print(filename);
                                              //   print(path);
                                              //   storage
                                              //       .uploadImage(path, filename)
                                              //       .then((value) {
                                              //     print('done');
                                              //   });
                                              //   _imageUrl=await storage.getImage(filename);
                                              //   print(_imageUrl);
                                              // },
                                              icon: const Icon(
                                                Icons.camera_alt_outlined,
                                                size: 24,
                                                color: greenClr,
                                              ),
                                            ),
                                          ),
                                        )
                                      ]),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            profile[0].image??
                                                'https://avatars.githubusercontent.com/u/93073520?v=4',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        //borderRadius: BorderRadius.all(Radius.circular(10)),
                                        border: Border.all(color: greenClr, width: 2),
                                        //color: greenClr,
                                        shape: BoxShape.circle,
                                      ),
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
                                      readOnly: true,
                                      label: 'Phone Number',
                                      hint: profile[0].phone.toString(),
                                      keyboardType: TextInputType.number,
                                    sufWidget: Visibility(
                                      visible: visible,
                                      child: IconButton(
                                        icon: (
                                            Icon(Icons.edit)), onPressed: () {  },
                                        // onPressed: ()=>_updateProfile(),
                                      ),
                                    ),

                                  ),
                                  const SizedBox(height: 30),
                                  TextInput(
                                      label: 'Other Phone',
                                      hint: profile[0].other.toString(),
                                      readOnly: true,
                                      keyboardType: TextInputType.number,
                                    sufWidget: Visibility(
                                      visible: visible,
                                      child: IconButton(
                                        icon: (
                                            Icon(Icons.edit)), onPressed: () {  },
                                        // onPressed: ()=>_updateProfile(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                      TextInput(
                                          label: 'Gender', readOnly: true, hint: profile[0].gender
                                        //  controller: genderController,
//error
                                      ),
                                  const SizedBox(height: 30),
                                  TextInput(
                                      label: 'Height',
                                      hint: profile[0].height.toString(),
                                      readOnly: true,
                                      keyboardType: TextInputType.number,
                                    sufWidget: Visibility(
                                      visible: visible,
                                      child: IconButton(
                                        icon: (
                                            Icon(Icons.edit)), onPressed: () {  },
                                        // onPressed: ()=>_updateProfile(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  TextInput(
                                      label: 'Weight',
                                      hint: profile[0].wight.toString(),
                                      //controller: weightController,
                                      keyboardType: TextInputType.number,
                                    sufWidget: Visibility(
                                      visible: visible,
                                      child: IconButton(
                                        icon: (
                                            Icon(Icons.edit)), onPressed: () {  },
                                        // onPressed: ()=>_updateProfile(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  ButtonWidget(
                                      text: visible==false?"Edit Profile":"Save",
                                      onPressed: () {
                                        setState(() {
                                          visible=!visible;
                                        });

                                        // FirebaseAuth.instance.signOut();
                                      }),
                                  const SizedBox(height: 60),
                                ],
                              );
                            });

                      },
                    )



                  );
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
  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null){
      print(FirebaseAuth.instance.currentUser!.uid);
      await FirebaseFirestore.instance.collection('UserData').doc(FirebaseAuth.instance.currentUser!.uid).
    get().then((ds) async{
      print(ds.data()!['name']);
      try{
        print(ds.data()!['name']);
       await Provider.of<ProfileProvider>(context,listen: false).
        addTask(task: Profile(
          id: ds.data()!['idCard'],
          name: ds.data()!['name'],
          type: ds.data()!['type'],
          height: ds.data()!['height'],
          email: ds.data()!['email'],
          birthday: ds.data()!['birth'],
          gender: ds.data()!['gender'],
          image: ds.data()!['image'],
          other:ds.data()!['otherPhone'] ,
          phone: ds.data()!['phone'],
          wight: ds.data()!['weight'],
        ));
      }catch (e){
        print(e);
      }

      print(ds.data()!['phone']);
      }).
 catchError((e) {
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
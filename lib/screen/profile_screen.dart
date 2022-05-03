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
  final ValueNotifier<String> _imageUrl = ValueNotifier('assets/images/logo_png.png');
  bool visible = false;
  bool readonly = true;
  late TextEditingController phoneController;
  late TextEditingController otherPhoneController;
  late TextEditingController heightController;
  late TextEditingController weightController;
   String image='';
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
  final firebaseUser = FirebaseAuth.instance.currentUser;
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
                      create: (context) =>Provider.of<ProfileProvider>(context, listen: false).getTask(),
                      child: Consumer<ProfileProvider>(
                        builder: (context, task, child) {
                            var profile =Provider.of<ProfileProvider>(context).listTask;
                            return Column(
                              children: [
                                const SizedBox(height: 2),
                                   ValueListenableBuilder(
                                      valueListenable: _imageUrl,
                                      builder: (context, String? value, child) {
                                        return Container(
                                          height: 150,
                                          width: 150,
                                          child: Visibility(
                                            visible: visible,
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: greenClr,
                                                      width: 2),
                                                ),
                                                child: IconButton(
                                                  onPressed: () async {
                                                    final result = await FilePicker.platform
                                                            .pickFiles(
                                                      allowMultiple: false,
                                                      type: FileType.custom,
                                                      allowedExtensions: [
                                                        'jpg',
                                                        'png',
                                                        'jpeg',
                                                      ],
                                                    );
                                                    if (result == null) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'No filere Selected')));
                                                      return null;
                                                    }
                                                    final path = result.files.single.path!;
                                                    final filename = result.files.single.name;
                                                    storage.uploadImage(path,filename).then((value) => print("Done"));

                                                   storage.getImage(filename).then((value) =>setState(() {
                                                     _imageUrl.value = image;
                                                     print("Image URL: $image");

                                                   })
                                                   );
                                                  },
                                                  icon: const Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: 36,
                                                    color: blueClr,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                 profile[0].image.toString(),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            border: Border.all(
                                                color: greenClr, width: 2),
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
                                  controller: phoneController,
                                  readOnly: !visible,
                                  label: 'Phone Number',
                                  hint: profile[0].phone.toString(),
                                  keyboardType: TextInputType.number,
                                  sufWidget: Visibility(
                                    visible: visible,
                                    child: IconButton(
                                      icon: (Icon(Icons.edit)),
                                      onPressed: () {
                                        phoneController.text =
                                            profile[0].phone.toString();
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextInput(
                                  controller: otherPhoneController,
                                  label: 'Other Phone',
                                  hint: profile[0].other.toString(),
                                  readOnly: !visible,
                                  keyboardType: TextInputType.number,
                                  sufWidget: Visibility(
                                    visible: visible,
                                    child: IconButton(
                                      icon: (Icon(Icons.edit)),
                                      onPressed: () {
                                        setState(() {
                                          otherPhoneController.text =
                                              profile[0].other.toString();
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
                                    hint: profile[0].gender),
                                const SizedBox(height: 30),
                                TextInput(
                                  controller: heightController,
                                  label: 'Height',
                                  hint: profile[0].height.toString(),
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
                                  hint: profile[0].height.toString(),
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
                                        ? "Update Profile"
                                        : "Save Profile",
                                    onPressed: () {
                                      visible == false
                                          ? setState(() {
                                              visible = !visible;
                                            })
                                          : setState(() {
                                              visible = !visible;
                                              // _updateProfile(
                                              //   profile: profile[0],
                                              //     height: heightController.text,
                                              //     otherPhone:
                                              //         otherPhoneController.text,
                                              //     phone: phoneController.text,
                                              //     weight: weightController.text,
                                              //     image: _imageUrl.value);
                                            });
                                    }),
                                const SizedBox(height: 60),
                              ],
                            );

                        },
                      ));
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }

  // _updateProfile(
  //     {required String height,
  //     required String otherPhone,
  //     required String phone,
  //     required String weight,
  //     required String image,
  //     required var profile
  //     }) async {
  //
  //   if (height != null) {
  //     await FirebaseFirestore.instance.collection('UserData')
  //         .doc(firebaseUser!.uid)
  //         .update({
  //       'height': height,
  //     });
  //
  //   }else{
  //     await FirebaseFirestore.instance.
  //   collection('UserData').doc(firebaseUser!.uid).update({
  //     'height': profile[0].height,
  //     });
  //
  //
  //
  //   }
  //   if (otherPhone != null) {
  //     await FirebaseFirestore.instance
  //         .collection('UserData')
  //         .doc(firebaseUser.uid)
  //         .update({
  //       'otherPhone': otherPhone,
  //     });
  //   }else{
  //     await FirebaseFirestore.instance.
  //     collection('UserData').doc(firebaseUser.uid).update({
  //       'otherPhone': profile[0].other,
  //     });
  //
  //
  //   }
  //
  //   if (phone != null) {
  //     await FirebaseFirestore.instance
  //         .collection('UserData')
  //         .doc(firebaseUser.uid)
  //         .update({
  //       'phone': phone,
  //     });
  //   }
  //   if (weight != null) {
  //     await FirebaseFirestore.instance
  //         .collection('UserData')
  //         .doc(firebaseUser.uid)
  //         .update({
  //       'weight': weight,
  //     });
  //   }
  //
  //   if (image != null) {
  //     await FirebaseFirestore.instance
  //         .collection('UserData')
  //         .doc(firebaseUser.uid)
  //         .update({
  //       'image': image,
  //     });
  //   }
  // }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
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
        } catch (e) {}
      }).catchError((e) {});
    }
  }
}

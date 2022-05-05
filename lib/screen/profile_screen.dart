import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_assistant/database/storage_fire.dart';
import 'package:medical_assistant/models/profile_model.dart';
import 'package:medical_assistant/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import '../provider/provider_language.dart';
import '../theme.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Storage storage = Storage();
  final ValueNotifier<String> _imageUrl =
      ValueNotifier('https://cdn.icon-icons.com/icons2/2643/PNG/512/male_boy_person_people_avatar_icon_159358.png');
  bool visible = false;
  bool readonly = true;
  late TextEditingController phoneController;
  late TextEditingController otherPhoneController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  // String image = '';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: const TextStyle(color: blueClr),
          textAlign: TextAlign.start,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language_outlined, color: blueClr),
            onPressed: () {
              Provider.of<LanguageProvider>(context,listen: false).changeLanguage();

            },
          ),
          SizedBox(width: 20),
        ],
      ),
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
                          var profile =
                              Provider.of<ProfileProvider>(context).listTask;
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: greenClr, width: 2),
                                            ),
                                            child: IconButton(
                                              onPressed: () async {
                                                final result = await FilePicker
                                                    .platform
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
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .no_file_selected)));
                                                  return;
                                                }
                                                final path =result.files.single.path!;
                                                final filename = result.files.single.name;
                                                storage.uploadImage(path, filename) .then((value) =>
                                                        print("Done"));

                                                _imageUrl.value = await storage.getImage(filename);
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
                                            _imageUrl.value,
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
                              const SizedBox(height: 30),
                              TextInput(
                                readOnly: true,
                                label: AppLocalizations.of(context)!.user_name,
                                hint: profile[0].name,
                              ),
                              const SizedBox(height: 30),
                              TextInput(
                                label: AppLocalizations.of(context)!.birthday,
                                readOnly: true,
                                hint: profile[0].birthday,
                              ),
                              const SizedBox(height: 30),
                              TextInput(
                                controller: phoneController,
                                readOnly: !visible,
                                label: AppLocalizations.of(context)!.phone,
                                hint: profile[0].phone.toString(),
                                keyboardType: TextInputType.number,
                                sufWidget: Visibility(
                                  visible: visible,
                                  child: IconButton(
                                    icon: (const Icon(Icons.edit)),
                                    onPressed: () {
                                      profile[0].phone.toString();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              TextInput(
                                controller: otherPhoneController,
                                label:
                                    AppLocalizations.of(context)!.other_phone,
                                hint: profile[0].other.toString(),
                                readOnly: !visible,
                                keyboardType: TextInputType.number,
                                sufWidget: Visibility(
                                  visible: visible,
                                  child: IconButton(
                                    icon: (const Icon(Icons.edit)),
                                    onPressed: () {
                                      setState(() {
                                        profile[0].other.toString();
                                      });
                                    },
                                    // onPressed: ()=>_updateProfile(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              TextInput(
                                  label: AppLocalizations.of(context)!.gender,
                                  readOnly: true,
                                  hint: profile[0].gender),
                              const SizedBox(height: 30),
                              TextInput(
                                controller: heightController,
                                label: AppLocalizations.of(context)!.height,
                                hint: profile[0].height.toString(),
                                readOnly: !visible,
                                keyboardType: TextInputType.number,
                                sufWidget: Visibility(
                                  visible: visible,
                                  child: IconButton(
                                    icon: (const Icon(Icons.edit)),
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
                                label: AppLocalizations.of(context)!.weight,
                                hint: profile[0].wight.toString(),
                                readOnly: !visible,
                                keyboardType: TextInputType.number,
                                sufWidget: Visibility(
                                  visible: visible,
                                  child: IconButton(
                                    icon: (const Icon(Icons.edit)),
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
                                      ? AppLocalizations.of(context)!
                                          .update_profile
                                      : AppLocalizations.of(context)!
                                          .save_profile,
                                  onPressed: () {
                                    visible == false
                                        ? setState(() {
                                            visible = !visible;
                                          })
                                        : setState(() {
                                            visible = !visible;
                                            _updateProfile(
                                                height: heightController.text,
                                                otherPhone:
                                                    otherPhoneController.text,
                                                phone: phoneController.text,
                                                weight: weightController.text,
                                                image: _imageUrl.value);
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

  _updateProfile({
    required String? height,
    required String? otherPhone,
    required String? phone,
    required String? weight,
    required String? image,
  }) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (height != "") {
      print("height");
      await FirebaseFirestore.instance
          .collection('UserData')
          .doc(firebaseUser!.uid)
          .update({
        'height': height,
      });
    }
    if (otherPhone != "") {
      print("otherPhone");
      await FirebaseFirestore.instance
          .collection('UserData')
          .doc(firebaseUser!.uid)
          .update({
        'otherPhone': otherPhone,
      });
    }

    if (phone != "") {
      print("phone");
      await FirebaseFirestore.instance
          .collection('UserData')
          .doc(firebaseUser!.uid)
          .update({
        'phone': phone,
      });
    }
    if (weight != "") {
      print("weight");
      await FirebaseFirestore.instance
          .collection('UserData')
          .doc(firebaseUser!.uid)
          .update({
        'weight': weight,
      });
    }

    if (image != "") {
      print("image");
      await FirebaseFirestore.instance
          .collection('UserData')
          .doc(firebaseUser!.uid)
          .update({
        'image': image,
      });
    }
  }

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

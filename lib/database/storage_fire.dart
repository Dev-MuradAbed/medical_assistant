import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_core/firebase_core.dart'as firebase_core;
import 'package:flutter/widgets.dart';
class Storage{
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> uploadImage(String filepath, String filename) async {
File file =File(filepath);
try{
  await _storage.ref('profile_image/$filename').putFile(file);

}on firebase_core.FirebaseException catch(e){
  print(e);

}
  }
  Future<String> getImage(String filename) async{
    return await _storage.ref('profile_image/$filename').getDownloadURL();
  }
}


import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_core/firebase_core.dart'as firebase_core;
import 'package:flutter/widgets.dart';
class Storage{
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> uploadImage(String path, String name) async {
File file =File(path);
try{
  await _storage.ref('test/$name').child(name).putFile(file);


}on firebase_core.FirebaseException catch(e){
  print(e);

}
  }
  Future<String> getImage(String name) async{
    return await _storage.ref('test/$name').child(name).getDownloadURL();
  }
}


import 'package:flutter/material.dart';

class DoctorProviderfire extends ChangeNotifier{
  String _uid='';
  String get uid=>_uid;
  void uidSetter(String uid){
    _uid=uid;
  }
}
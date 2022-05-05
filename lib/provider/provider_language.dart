import 'package:flutter/material.dart';

import '../storge/pref_controller.dart';


class LanguageProvider extends ChangeNotifier {
  String language = SharedPrefController().language;

  void changeLanguage() async{
    language = language == 'en' ? 'ar' : 'en';
    await SharedPrefController().changeLanguage(language);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import '../storge/pref_controller.dart';


class LanguageProvider extends ChangeNotifier {
  String language = SharedPrefController().language;

  void changeLanguage() {
    language = language == 'en' ? 'ar' : 'en';
    notifyListeners();
  }
}

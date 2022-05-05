import 'package:shared_preferences/shared_preferences.dart';

enum PrefKey {
  language,
}

class SharedPrefController {

  static final SharedPrefController instance = SharedPrefController._();

  factory SharedPrefController() {
    return instance;
  }
  late SharedPreferences sharedPreferences;
  SharedPrefController._();

  Future<void> initPref() async {
    sharedPreferences = await SharedPreferences.getInstance();

  }

  Future<bool>changeLanguage(String language)async{
    return await sharedPreferences.setString(PrefKey.language.toString(), language);
  }
  String get language => sharedPreferences.getString(PrefKey.language.toString())??'en';
}

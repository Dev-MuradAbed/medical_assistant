import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final _key = 'isDarkMode';
  final GetStorage _box = GetStorage();

  _SaveModeinBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  bool _LoadModeFromBox() => _box.read<bool>(_key) ?? false;

  ThemeMode get theme =>_LoadModeFromBox()?ThemeMode.dark:ThemeMode.light;
  switchTheme(){
    Get.changeThemeMode(_LoadModeFromBox()?ThemeMode.light:ThemeMode.dark);
    _SaveModeinBox(!_LoadModeFromBox());
  }
}

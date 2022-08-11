import 'package:flutter/material.dart';
import 'package:home_expcenses/helper/settingHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool? isDark;

  SettingsProvider() {
    isDark = SPhelper.sPhelper.sp!.getBool('dark')!;
  }

  changeTheme(bool value) {
    isDark = value;
    SPhelper.sPhelper.changeTheme(value);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:lost_time/config/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  String _currentTheme = 'dark';
  String get currentTheme => _currentTheme;

  ThemeData currentThemeData = ThemeData.dark();

  void setTheme(String theme) async {
    if (theme == 'light') {
      currentThemeData = lightTheme;
    } else {
      currentThemeData = darkTheme;
    }

    _currentTheme = theme;
    saveTheme();
    notifyListeners();
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs.getString('theme') ?? 'dark';
    setTheme(savedTheme);
    notifyListeners();
  }

  Future<void> saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', _currentTheme);
  }
}

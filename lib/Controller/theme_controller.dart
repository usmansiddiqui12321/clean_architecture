import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final GetStorage _box = GetStorage();
  final String _key = 'isDarkMode';

  // Get the current theme mode
  ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;

  // Load the theme from storage
  bool _loadTheme() => _box.read(_key) ?? false;

  // Save the theme to storage
  void _saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);

  // Toggle the theme
  void toggleTheme() {
    bool isDarkMode = _loadTheme();
    _saveTheme(!isDarkMode);
    Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    update();
  }
}

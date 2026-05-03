import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find<ThemeController>();

  static const String _prefsKey = 'theme_mode'; // 'system' | 'light' | 'dark'

  /// Defaults to [ThemeMode.system] so the app follows the OS setting until
  /// the user explicitly picks light or dark.
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  /// Resolved dark state — considers the platform brightness when in
  /// [ThemeMode.system]. Useful for UI that needs to branch on the active
  /// theme without a [BuildContext].
  bool get isDarkMode {
    if (_themeMode.value == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode.value == ThemeMode.dark;
  }

  bool get isSystem => _themeMode.value == ThemeMode.system;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode.value = _fromString(prefs.getString(_prefsKey));
    Get.changeThemeMode(_themeMode.value);
  }

  Future<void> setMode(ThemeMode mode) async {
    _themeMode.value = mode;
    Get.changeThemeMode(mode);
    await _persist(mode);
  }

  Future<void> toggleTheme() async {
    final next = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await setMode(next);
  }

  Future<void> switchTheme(bool dark) =>
      setMode(dark ? ThemeMode.dark : ThemeMode.light);

  Future<void> useSystem() => setMode(ThemeMode.system);

  ThemeMode _fromString(String? raw) => switch (raw) {
    'dark' => ThemeMode.dark,
    'light' => ThemeMode.light,
    _ => ThemeMode.system,
  };

  String _toString(ThemeMode mode) => switch (mode) {
    ThemeMode.dark => 'dark',
    ThemeMode.light => 'light',
    ThemeMode.system => 'system',
  };

  Future<void> _persist(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, _toString(mode));
  }
}

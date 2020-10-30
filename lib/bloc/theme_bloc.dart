import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeModes = [
  ThemeMode.system,
  ThemeMode.light,
  ThemeMode.dark,
];

extension _ThemeIndex on ThemeMode {
  int toInt() => _themeModes.indexOf(this);
}

extension _IndexTheme on int {
  ThemeMode toThemeMode() => _themeModes[this];
}

class ThemeBloc extends Cubit<ThemeMode> {
  ThemeBloc() : super(_defaultTheme) {
    _loadFromPreferences();
  }

  static const _defaultTheme = ThemeMode.system;
  static const _themeKey = 'app_theme_mode';

  Future<void> _loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    emit(prefs.getInt(_themeKey)?.toThemeMode() ?? _defaultTheme);
  }

  Future<void> update(ThemeMode newMode) async {
    if (newMode == state) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, newMode.toInt() ?? 0);

    emit(newMode);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _allColors = [
  Colors.pink,
  Colors.red,
  Colors.deepOrange,
  Colors.orange,
  Colors.amber,
  Colors.yellow,
  Colors.lime,
  Colors.lightGreen,
  Colors.green,
  Colors.teal,
  Colors.cyan,
  Colors.lightBlue,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
  Colors.deepPurple,
  Colors.blueGrey,
  Colors.brown,
];

extension _ColorToInt on Color {
  int toInt() => _allColors.indexOf(this);
}

extension _IntToColor on int {
  Color toColor() => _allColors[this];
}

class ColorBloc extends Cubit<Color> {
  ColorBloc() : super(_defaultColor) {
    _loadFromPreferences();
  }

  static const _defaultColor = Colors.blue;
  static const _colorKey = 'app_color';

  List<Color> get possibleColors => _allColors;

  Future<void> _loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    emit(prefs.getInt(_colorKey)?.toColor() ?? _defaultColor);
  }

  Future<void> update(Color newColor) async {
    if (newColor == state) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_colorKey, newColor.toInt() ?? 0);

    emit(newColor);
  }
}

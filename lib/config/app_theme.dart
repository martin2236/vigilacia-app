import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme(){
    final seedColor =Colors.lightBlue.shade200;
    return ThemeData(
      colorSchemeSeed: seedColor
    );
  }
}
import 'package:flutter/material.dart';

import '../../constants/my_colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorSchemeSeed: MyColors.colorPrimary,

    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white, // Default icon color in AppBar
      ),

  ),

);
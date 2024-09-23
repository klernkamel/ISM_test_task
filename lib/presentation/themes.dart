import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

final initialLightTheme = ThemeData.light().copyWith(
  appBarTheme: const AppBarTheme().copyWith(
    color: HexColor('181935'),
    titleTextStyle: TextStyle(
      color: HexColor('F2F1EF'),
      fontWeight: FontWeight.w500,
      letterSpacing: -0.5,
      fontSize: 22,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme().copyWith(
    labelStyle: const TextStyle(
      letterSpacing: -1,
    ),
    floatingLabelStyle: TextStyle(
      color: HexColor('173187'),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: HexColor('C3C4BF'),
        )),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: HexColor('173187'),
        )),
  ),
  iconTheme: const IconThemeData().copyWith(
    color: HexColor('173181'),
  ),
  primaryColor: HexColor('173181'),
  scaffoldBackgroundColor: HexColor('AEADAD'),
);

final initialDarkTheme = ThemeData.dark();

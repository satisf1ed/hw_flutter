import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xfff82810);

final darkTheme = ThemeData(
  primaryColor: primaryColor,
  useMaterial3: true,
  textTheme: textTheme,
  scaffoldBackgroundColor: Colors.black87,
  backgroundColor: Colors.black45,
  colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor, brightness: Brightness.dark),
);

final lightTheme = ThemeData(
  primaryColor: primaryColor,
  useMaterial3: true,
  textTheme: textTheme,
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: CupertinoColors.systemGrey5,
  colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor, brightness: Brightness.light),
);

const textTheme = TextTheme(
    titleMedium: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ));

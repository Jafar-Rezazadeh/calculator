import 'dart:ui';

import 'package:flutter/material.dart';

// Light side
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  //

  textTheme: const TextTheme(
    labelLarge: TextStyle(color: Colors.black),
    labelSmall: TextStyle(color: Colors.black),
    titleSmall: TextStyle(color: Colors.grey),
    titleLarge: TextStyle(color: Colors.blue),
  ),
  //
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith((states) =>
            states.contains(MaterialState.pressed) ? Colors.blue[200] : null),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black)),
  ),
  //
);

// DarkSide
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  //
  scaffoldBackgroundColor: const Color.fromRGBO(48, 48, 48, 1),
  textTheme: const TextTheme(
    labelLarge: TextStyle(color: Colors.grey),
    titleSmall: TextStyle(color: Colors.grey),
    titleLarge: TextStyle(color: Colors.white),
  ),
  //
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.resolveWith(
        (states) =>
            states.contains(MaterialState.pressed) ? Colors.grey[600] : null,
      ),
      backgroundColor: MaterialStateProperty.all<Color>(
        const Color.fromRGBO(48, 48, 48, 1),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
  ),
);

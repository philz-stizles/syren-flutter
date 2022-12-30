import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'palette.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Palette.buildMaterialColor(Palette.primary),
      primaryColor: Palette.primary,
      fontFamily: GoogleFonts.poppins().fontFamily,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: appBarTheme(),
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      elevatedButtonTheme: elevatedButtonTheme(),
      unselectedWidgetColor: iPrimaryColor);
}

final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: iPrimaryColor,
    fontFamily: 'Century Gothic',
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    elevatedButtonTheme: elevatedButtonTheme());

// Input Themes.
InputDecorationTheme inputDecorationTheme() {
  // OutlineInputBorder bOutlineInputBorder = OutlineInputBorder(
  //   borderSide:
  //       const BorderSide(color: Color.fromARGB(255, 123, 122, 122), width: 1),
  //   borderRadius: BorderRadius.circular(5),
  // );

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Palette.secondary,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(secondaryBorderRadius),
  );

  return InputDecorationTheme(
    hintStyle: const TextStyle(color: Palette.grey, fontSize: 12),
    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    enabledBorder: outlineInputBorder, // bOutlineInputBorder,
    focusedBorder: outlineInputBorder, // bOutlineInputBorder,
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFFEDEDED),
        width: 0,
      ),
      borderRadius: BorderRadius.circular(5),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    headlineLarge: TextStyle(
        fontSize: 18,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: Color(0xFF52536D)),
    bodyLarge: TextStyle(
        fontSize: 14,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        color: Color(0xFF7B839C)),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Color.fromRGBO(101, 102, 106, 1),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: Color(0xFF7B839C),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
    ),
  );
}

// AppBar Themes.
AppBarTheme appBarTheme() {
  return const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(defaultBorderRadius),
      ),
    ),
  );
}

// Button Themes.
ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          disabledBackgroundColor: Colors.grey.shade500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(secondaryBorderRadius),
          )));
}

class MainTheme {
  static TextStyle body = const TextStyle(
    fontFamily: 'Century Gothic',
    fontSize: 14,
    color: Color.fromRGBO(101, 102, 106, 1),
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  static TextStyle hint = const TextStyle(
    fontFamily: 'Century Gothic',
    fontSize: 14,
    color: Color.fromRGBO(101, 102, 106, 1),
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  static TextStyle header = const TextStyle(
    fontFamily: 'Century Gothic',
    fontSize: 22,
    color: Color.fromRGBO(10, 10, 10, 1),
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w800,
  );

  static TextStyle subtitle = const TextStyle(
    fontFamily: 'Century Gothic',
    fontSize: 14,
    color: Color.fromRGBO(56, 56, 56, 1),
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w800,
  );

  static OutlineInputBorder inputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
        color: Colors.transparent, width: 0, style: BorderStyle.none),
    borderRadius: BorderRadius.circular(3),
  );
}

class AppTextStyles {
  static TextStyle defaultStyle = const TextStyle(
    fontFamily: 'Century Gothic',
    fontSize: 14,
    color: Color.fromRGBO(101, 102, 106, 1),
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
  );
  static TextStyle topHeader = GoogleFonts.carroisGothic(
      fontSize: 22,
      color: const Color.fromRGBO(10, 10, 10, 1),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w800);
  static TextStyle dialogSubTitle = GoogleFonts.carroisGothic(
      fontSize: 12,
      color: const Color.fromRGBO(56, 56, 56, 1),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400);
}

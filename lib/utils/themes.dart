import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'palette.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Palette.dimWhite,
      primarySwatch: Palette.buildMaterialColor(Palette.primary),
      primaryColor: Palette.primary,
      fontFamily: GoogleFonts.inter().fontFamily,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: appBarTheme(),
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      elevatedButtonTheme: elevatedButtonTheme(),
      unselectedWidgetColor: Palette.primary,
      bottomNavigationBarTheme: bottomNavigationBarTheme());
}

ThemeData darkTheme() {
  return ThemeData(
      scaffoldBackgroundColor: Palette.dimWhite,
      brightness: Brightness.dark,
      primarySwatch: Palette.buildMaterialColor(Palette.primary),
      primaryColor: Palette.primary,
      fontFamily: GoogleFonts.poppins().fontFamily,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: appBarTheme(),
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      elevatedButtonTheme: elevatedButtonTheme(),
      unselectedWidgetColor: Palette.primary,
      bottomNavigationBarTheme: bottomNavigationBarTheme());
}

// Input Themes.
InputDecorationTheme inputDecorationTheme() {
  // OutlineInputBorder bOutlineInputBorder = OutlineInputBorder(
  //   borderSide:
  //       const BorderSide(color: Color.fromARGB(255, 123, 122, 122), width: 1),
  //   borderRadius: BorderRadius.circular(5),
  // );

  OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color(0xFEFE0000),
      width: 1, // width: 0
    ),
    borderRadius: BorderRadius.circular(5),
  );

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Palette.grey,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(secondaryBorderRadius),
  );

  return InputDecorationTheme(
    hintStyle: const TextStyle(color: Palette.grey, fontSize: 14),
    errorStyle: const TextStyle(fontSize: 12),
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
    errorBorder: errorBorder,
    focusedErrorBorder: errorBorder,
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
    iconTheme: IconThemeData(size: 20, color: Palette.white),
    titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(defaultBorderRadius),
      ),
    ),
  );
}

// BottomNavigationBar Themes.
BottomNavigationBarThemeData bottomNavigationBarTheme() {
  return const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent, // Palette.white,
    type: BottomNavigationBarType.fixed,
    elevation: 0, //10,
    selectedItemColor: Palette.primary,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: TextStyle(
        color: Palette.primary, fontWeight: FontWeight.w400, fontSize: 11),
    unselectedLabelStyle: TextStyle(
        color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 11),
    showUnselectedLabels: true,
    // selectedIconTheme:
    //     const IconThemeData(color: Color.fromRGBO(254, 0, 0, 1)),
    // unselectedIconTheme: const IconThemeData(color: Colors.grey),
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

class AppTextStyles {
  static TextStyle headingStyle = GoogleFonts.poppins(
      textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
  static TextStyle subHeadingStyle = GoogleFonts.poppins(
      textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  static TextStyle labelStyle = GoogleFonts.poppins(
      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold));
}

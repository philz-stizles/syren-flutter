import 'package:flutter/material.dart';

// TEXT
const signupText = '';
const logoutText = 'Sign out';

const iPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFF4D4D), Color(0xFEFE0000)],
);
const iSecondaryColor = Color(0xFF979797);
const iSecondaryLightColor = Color(0xFF979797);

const iSuccessColor = Color(0xFF00C48C);
const iTextColor = Color(0xFF757575);

const iBorderColor = Color.fromARGB(106, 164, 165, 167);

const defaultBorderRadius = 30.0;
const secondaryBorderRadius = 5.0;
const mediumBorderRadius = 10.0;
const defaultScreenPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 20);

const animationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 28, // getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

final otpInputDecoration = InputDecoration(
  // contentPadding:
  //     EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return const OutlineInputBorder(
    // borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: iTextColor),
  );
}

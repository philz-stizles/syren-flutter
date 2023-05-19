import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:syren/utils/palette.dart';

// API
var googleMapsApiKey = dotenv.get('GOOGLE_MAPS_API_KEY');

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

const defaultBorderRadius = 30.0;
const secondaryBorderRadius = 5.0;
const mediumBorderRadius = 10.0;
const defaultScreenPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 20);

const animationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 20, // getProportionateScreenWidth(28),
  fontWeight: FontWeight.w700,
  color: Palette.secondary,
  height: 2.4,
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
  return OutlineInputBorder(
    borderSide: const BorderSide(
      color: Palette.grey,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(mediumBorderRadius),
  );
}

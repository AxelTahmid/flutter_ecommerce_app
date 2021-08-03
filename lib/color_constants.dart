import 'package:flutter/material.dart';
import 'package:we_deliver_bd/media_size_config.dart';

class ColorConstants {
  static const kPrimaryColor = Colors.red;
  static const kPrimaryLightColor = Colors.redAccent;

  static const kSecondaryColor = Colors.green;
  static const KSecondaryLightColor = Colors.greenAccent;

  static const kPrimaryTextColor = Colors.white;
  static const kSecondaryTextColor = Colors.black;

  static const kAnimationDuration = Duration(milliseconds: 200);

  final headingStyle = TextStyle(
    fontSize: getProportionateScreenWidth(28),
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.5,
  );
}




// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
// );
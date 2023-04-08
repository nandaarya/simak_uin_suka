import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 24.0;
Color primaryColor = const Color(0xffcc9933);
Color backgroundColor = const Color(0xffF8F8F8);
Color alertColor = const Color(0xffED6363);
TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: Colors.black,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

// Function failFlashBar = (BuildContext context, message) {
//   Flushbar(
//     message: message,
//     duration: Duration(seconds: 2),
//     flushbarPosition: FlushbarPosition.TOP,
//     backgroundColor: Colors.red,
//   )..show(context);
// };
//
// Function successFlashBar = (BuildContext context, message) {
//   Flushbar(
//     message: message,
//     duration: Duration(seconds: 2),
//     flushbarPosition: FlushbarPosition.TOP,
//     backgroundColor: Colors.lightGreen,
//   )..show(context);
// };
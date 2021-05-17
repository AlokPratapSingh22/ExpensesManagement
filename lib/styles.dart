import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

/// Convenience class to access application colors.
abstract class AppColors {
  static final textTheme = GoogleFonts.actorTextTheme().copyWith(
    headline6: GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: Colors.black,
    ),
    bodyText1: GoogleFonts.ptSans(
        fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
    bodyText2: GoogleFonts.ptSans(
        fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black54),
    headline5: GoogleFonts.sairaCondensed(fontSize: 16, color: Colors.black45),
  );

  static final formTheme = GoogleFonts.abelTextTheme().copyWith(
    headline6: GoogleFonts.poppins(
        fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
    bodyText1: GoogleFonts.abel(
        fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
    bodyText2: GoogleFonts.poppins(
        fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
    button: GoogleFonts.abelTextTheme().button,
  );

  /// Dark background color.
  static const Color backgroundColor = Color(0xFF191D1F);

  /// Slightly lighter version of [backgroundColor].
  static const Color backgroundFadedColor = Color(0xFF191B1C);

  /// Color used for cards and surfaces.
  static const Color cardColor = Colors.white;

  /// Accent color used in the application.
  static const Color accentColor = Colors.black;
}

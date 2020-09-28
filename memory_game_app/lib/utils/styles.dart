import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static Color mainBackgroundColor = Colors.white;

  static ThemeData mainTheme = ThemeData(
    cursorColor: Colors.deepPurple,
    primaryColor: Colors.deepPurple,
    accentColor: Colors.deepPurple.shade900,
    textSelectionHandleColor: Colors.deepPurple,
    textTheme: GoogleFonts.poppinsTextTheme(),
    backgroundColor: Colors.white,
  );

  static BorderRadius defaultBorderRadius =
      BorderRadius.all(Radius.circular(4));

  static BoxDecoration card = BoxDecoration(
    color: mainBackgroundColor,
    borderRadius: defaultBorderRadius,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade400,
        offset: Offset(1, 1),
        blurRadius: 2,
      ),
    ],
  );
}

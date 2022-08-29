import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  //textTheme: GoogleFonts.robotoMonoTextTheme(),
  primaryColorDark: const Color.fromARGB(255, 12, 81, 141),
  primaryColorLight: const Color.fromARGB(255, 17, 137, 218),
  primaryColor: const Color.fromARGB(255, 17, 111, 206),
  colorScheme:
      const ColorScheme.light(secondary: Color.fromARGB(255, 0, 104, 188)),
  scaffoldBackgroundColor:const Color.fromARGB(255, 229, 243, 254),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);

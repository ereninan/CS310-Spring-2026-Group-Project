import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AppUtils {

  static const Color primaryColor = Color.fromARGB(255, 255, 255, 255);
  static const Color appBlue = Color.fromARGB(255, 4, 0, 255);
  static TextStyle smallButtons = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle product_card_title = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle product_card_price = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w300,
  );
  static TextStyle title_Style = GoogleFonts.poppins(
    fontSize: 32,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static const double defaultPadding = 16.0;
  
  static const TextStyle headerStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const Color myColor = Color(0xFF004890);
  static const double pad = 16.0;

  static const TextStyle titleStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: myColor,
  );
}

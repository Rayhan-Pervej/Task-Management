import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';

class TextDesign {
  TextStyle pageTitle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: MyColor.headerBlue,
  );
  TextStyle containerHeader = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: MyColor.black,
  );
  
  TextStyle fieldLabel = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: MyColor.black,
  );

  TextStyle fieldHint = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: MyColor.black,
  );

  TextStyle taskName = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: MyColor.black,
  );
}

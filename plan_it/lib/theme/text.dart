import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';

class TextDesign {
  // Final
  TextStyle navText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: MyColor.white,
  );
  TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: MyColor.white,
  );

  TextStyle headerLarge = GoogleFonts.poppins(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: MyColor.black,
  );

  TextStyle pageTitle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: MyColor.headerBlue,
  );
  TextStyle input = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: MyColor.black,
  );
  TextStyle fieldLabel = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: MyColor.black,
  );
  TextStyle header = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: MyColor.black,
  );
  TextStyle validator = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: MyColor.containerRed,
  );
  TextStyle bodyText = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: MyColor.black,
  );
  TextStyle snackBar = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: MyColor.white,
  );

  // not final need to edit
  TextStyle containerHeader = GoogleFonts.poppins(
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

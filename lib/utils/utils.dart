import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

//Colors
class CustomColors{

  static Color blue300 = const Color(0xFF3D43CC);
  static Color blue200 = const Color(0xFF2E3299);
  static Color redAlert = const Color(0xFFEA005A);
  static Color hintGrey = const Color(0xFF86848E);
  static Color dividerModal = const Color(0xFFCDCFD0);
  static Color neutral700 = const Color(0xFFF2F2F5);
  static Color neutral300 = const Color(0xFF595A67);
  static Color offButton = const Color(0xFFB2B2B9);
  static Color blackText = const Color(0xFF25242E);


}

class CustomIcons{
  Icon errorAlert = Icon(Icons.error_outlined, color: CustomColors.redAlert);
}

//Fonts
class Fonts{

  static String? defaultText =  GoogleFonts.mulish().fontFamily;
  static String? inputText =  GoogleFonts.inter().fontFamily;

}

//Extension
extension RouterContextExtension on BuildContext {

  Future showBottomSheet(
      Widget page, {
        bool isScrollControlled = true,
      }) {
    return showModalBottomSheet(
      isScrollControlled: isScrollControlled,
      context: this,
      builder: (context) => page,
    );
  }
}

class BarCode{


  bool validator(String text){
    RegExp regexBarCode = RegExp(r'^\d{13}$');
    return text.isNotEmpty && regexBarCode.hasMatch(text);
  }
}


//Checking field

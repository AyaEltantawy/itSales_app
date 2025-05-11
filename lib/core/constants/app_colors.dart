import 'package:flutter/material.dart';

import '../app/app.dart';

class AppColors {

  /* <----------- Colors ------------> */
  /// General Colors
  static const Color success = Color(0xFF74E291);
  static const Color danger = Color(0xFFFF004D);
  static const Color warning = Color(0xFFFE7A36);
  static const Color info = Color(0xFF864AF9);

  /// Primary Color of this App 014BA7
  static const Color primary = Color(0xFF17594A);
  static const Color secondary = Color(0xFF2A45AF);

  static Color textPrimary = globalDark ?
  Colors.white : Colors.black;
  static const Color textSecondary = Color(0xFF575B61);

  /// Background Variables
  static const Color background = Color(0xFFFCFCFD);
  static const Color darkBackground = Color(0xFF080A10);

  // Others Color
  static  Color scaffoldBackground = globalDark ?
  Color(0xFF000000) :  Color(0xFFF7F7F7);
  static  Color textWhite =  Color(0xFFFFFFFF);
  static  Color textBlack =  Color(0xFF000000);
  static  Color textGreySubTitle =
  globalDark ? Color(0xFFE6F4ED) : Color(0xFF575B61);
  static const Color errorColor = Colors.red;
  static const Color greenColor = Colors.green;
  static  Color lightGreenColor = globalDark ? Color(0xFF575B61) : Color(0xFFE6F4ED);


  /// used for page with box background
  ///
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color cardColorDark = Color(0xFF0E1016);

  static const Color borderColor = Color(0xFF8B8B97);
  static const Color borderColorDark = Color(0xFF1A1D2C);


  static  Color scaffoldWithBoxBackground =  globalDark ? textBlack : Color(0xFFF7F7F7);
  static  Color coloredBackground =
  globalDark ? textBlack : Color(0xFFEDF4FF);
  static const Color inbox = Color(0xFFCCD8E6);
  static  Color placeholder =  globalDark ? inbox : Color(0xFF8B8B97);
  static  Color backArrowsContainerColor = Color(0xFFE1E1E1);
  static  Color textInputBackground = globalDark ? textBlack : Color(0xFFF7F7F7);
  static const Color progress = Color(0xFFFF9C33);
  static const Color canceled = Color(0xFFFBDADD);
  static const Color gray = Color(0xFFE1E1E1);
  static const Color filterColor = Color(0xffc4c2c2);
  static const Color tinyTexts =   Color(0xff00000cc);
}

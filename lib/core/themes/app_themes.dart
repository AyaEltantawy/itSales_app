import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_defaults.dart';

class AppTheme {
  static ThemeData get defaultTheme {
    return ThemeData(
      colorSchemeSeed: AppColors.primary,
      fontFamily: "Tajawal",
      textTheme:  TextTheme(

        labelMedium:  TextStyle(color: AppColors.textBlack,fontSize: 16.sp ),
        bodyLarge: TextStyle(color: AppColors.textBlack,fontSize: 18.sp ),
        bodyMedium: TextStyle(color: AppColors.textBlack,fontSize: 18.sp),


        headlineLarge: TextStyle(color: AppColors.textBlack),
        bodySmall: TextStyle(color: AppColors.textBlack),
        titleLarge: TextStyle(color: AppColors.textBlack),
        titleMedium: TextStyle(color: AppColors.textBlack),
        titleSmall: TextStyle(color: AppColors.textBlack),
        labelSmall: TextStyle(color: AppColors.textBlack),
        displayLarge: TextStyle(color: AppColors.textBlack),
        displayMedium: TextStyle(color: AppColors.textBlack),
        displaySmall: TextStyle(color: AppColors.textBlack),
        headlineMedium: TextStyle(color: AppColors.textBlack),
        headlineSmall: TextStyle(color: AppColors.textBlack),
        labelLarge: TextStyle(color: AppColors.textBlack),




      ),
      scaffoldBackgroundColor: AppColors.background,
floatingActionButtonTheme: const FloatingActionButtonThemeData(
  backgroundColor: AppColors.primary,
  foregroundColor: AppColors.primary,
  focusColor: AppColors.primary,
  hoverColor: AppColors.primary,
  splashColor: AppColors.primary,
),
      brightness: Brightness.light,
      appBarTheme:  AppBarTheme(
        elevation: 0.3,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: GoogleFonts.tajawal(
          color: Colors.black,
          fontWeight: FontWeight.bold,

        ),

        systemOverlayStyle:  SystemUiOverlayStyle(

          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.textWhite,
          statusBarIconBrightness: Brightness.dark,

        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,

          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(AppDefaults.padding),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppDefaults.borderRadius,
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(AppDefaults.padding),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppDefaults.borderRadius,
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle:  GoogleFonts.tajawal(
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
      inputDecorationTheme: defaultInputDecorationTheme,
      sliderTheme: const SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
        thumbColor: Colors.white,
      ),
      tabBarTheme:  TabBarTheme(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.placeholder,
        labelPadding: const EdgeInsets.all(AppDefaults.padding),
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: GoogleFonts.tajawal(
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        unselectedLabelStyle: GoogleFonts.tajawal(
          fontWeight: FontWeight.bold,
          color: AppColors.placeholder,
        ),
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: "Tajawal",
      primaryColor: Colors.black,
      primaryColorLight: Colors.black,
      primaryColorDark: Colors.black,
      indicatorColor: Colors.white,
      canvasColor: Colors.black,

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
foregroundColor: AppColors.primary,
        focusColor: AppColors.primary,
        hoverColor: AppColors.primary,
        splashColor: AppColors.primary,
      ),
      textTheme: TextTheme(

        labelMedium: TextStyle(
            color: Colors.white, fontSize: 16.sp),
        bodyLarge: TextStyle(color: Colors.white, fontSize: 18.sp),
        bodyMedium: TextStyle(color: Colors.white, fontSize: 18.sp),

        headlineLarge: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
        labelSmall: TextStyle(color: Colors.white),
        displayLarge: TextStyle(color: Colors.white),
        displayMedium: TextStyle(color: Colors.white),
        displaySmall: TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),
        labelLarge: TextStyle(color: Colors.white),


      ),
      scaffoldBackgroundColor: AppColors.darkBackground,

      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        elevation: 0.3,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white, ),
        titleTextStyle: GoogleFonts.tajawal(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        systemOverlayStyle:  SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      // Add other theme configurations as needed, similar to your light theme
    );
  }


  /* <---- Input Decorations Theme -----> */
  static final defaultInputDecorationTheme = InputDecorationTheme(
    fillColor: AppColors.textInputBackground,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 0.1),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.1),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.1),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    suffixIconColor: AppColors.placeholder,
  );

  static final secondaryInputDecorationTheme = InputDecorationTheme(
    fillColor: AppColors.textInputBackground,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
  );

  static final otpInputDecorationTheme = InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderSide: const BorderSide(width: 0.1),
      borderRadius: BorderRadius.circular(25),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 0.1),
      borderRadius: BorderRadius.circular(25),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 0.1),
      borderRadius: BorderRadius.circular(25),
    ),
  );
}

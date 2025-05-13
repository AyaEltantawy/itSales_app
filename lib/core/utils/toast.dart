import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';

void successMotionToast(context,
    {
  required String text,

}) {
  MotionToast toast = MotionToast.success(

    height: 20.h,
    description:  Text(
      text,
      style: AppFonts.style20whiteMedium,
    ),
    dismissable: true,
    position: MotionToastPosition.top,
    animationType: AnimationType.fromRight,
    opacity: .8,
  );
  toast.show(context);
}

void warningMotionToast(context, {
  required String text,

}) {
  MotionToast.warning(

    title:  Text(
      'warning',
      style: AppFonts.style20BoldColored,
    ),
    barrierColor:Colors.white,
    description:  Text(text, style: AppFonts.style16LightPrimary,),
    animationCurve: Curves.linear,
    animationType: AnimationType.fromBottom,
    borderRadius: 0,
    animationDuration: const Duration(milliseconds: 1000),
    opacity: .9,
  ).show(context);
}

void errorMotionToast(context,
    {
      required String text,

    }) {
  MotionToast.error(

    title:  Text(
      'هناك خطأ',
      style: AppFonts.style20whiteMedium,
    ),
    description:  Text(text,style: AppFonts.style14normalWhite,),
    position: MotionToastPosition.bottom,
    barrierColor: AppColors.textWhite,

    animationType: AnimationType.fromRight ,

    width: 300.w,
    height: 80.h,
    dismissable: false,
  ).show(context);
}

void displayInfoMotionToast(context) {
  MotionToast.info(
    title: const Text(
      'Info Motion Toast',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    position: MotionToastPosition.bottom,
    description: const Text('Example of Info Toast'),
  ).show(context);
}

void displayResponsiveMotionToast(context) {
  MotionToast(
    icon: Icons.rocket_launch,
    primaryColor: Colors.purple,
    title: const Text(
      'Custom Toast',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: const Text(
      'Hello my name is Flutter dev',
    ),
  ).show(context);
}

void displayCustomMotionToast(context) {
  MotionToast(
    width: MediaQuery.of(context).size.width * 0.75,
    height: MediaQuery.of(context).size.height * 0.10,
    primaryColor: Colors.white,
    title: const Text(
      'Bugatti',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    dismissable: false,
    description: const Text(
      'Automobiles Ettore Bugatti was a German then French manufacturer of high-performance automobiles. The company was founded in 1909 in the then-German city of Molsheim, Alsace, by the Italian-born industrial designer Ettore Bugatti. ',
    ),
  ).show(context);
}

void displayMotionToastWithoutSideBar(context) {
  MotionToast(
    icon: Icons.zoom_out,
    primaryColor: Colors.white,
    secondaryColor: Colors.grey,
    title: const Text('Two Color Motion Toast'),
    description: const Text('Another motion toast example'),
    displayBorder: true,
    displaySideBar: false,
  ).show(context);
}

void displayMotionToastWithBorder(context) {
  MotionToast(
    icon: Icons.zoom_out,
    primaryColor: Colors.deepOrange,
    title: const Text('Top Motion Toast'),
    description: const Text('Another motion toast example'),
    position: MotionToastPosition.top,
    animationType: AnimationType.fromBottom,
    displayBorder: true,
    width: 350,
    height: 100,
    margin: const EdgeInsets.only(
      top: 30,
    ),
  ).show(context);
}

void displayTwoColorsMotionToast(context) {
  MotionToast(
    icon: Icons.zoom_out,
    primaryColor: Colors.white,
    secondaryColor: Colors.grey,
    title: const Text(
      'Two Color Motion Toast',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: const Text('Another motion toast example'),
    position: MotionToastPosition.bottom,
    animationType: AnimationType.fromBottom,
    width: 350,
    height: 100,
  ).show(context);
}

void displayTransparentMotionToast(context) {
  MotionToast(
    icon: Icons.zoom_out,
    primaryColor: Colors.grey[400]!,
    secondaryColor: Colors.white,
    title: const Text(
      'Two Color Motion Toast',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: const Text('Another motion toast example'),
    position: MotionToastPosition.center,
    width: 350,
    height: 100,
  ).show(context);
}

void displaySimultaneouslyToasts(context) {
  MotionToast.warning(
    title: const Text(
      'Warning Motion Toast',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: const Text('This is a Warning'),
    animationCurve: Curves.bounceIn,
    borderRadius: 0,
    animationDuration: const Duration(milliseconds: 1000),
  ).show(context);
  MotionToast.error(
    title: const Text(
      'Error',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: const Text('Please enter your name'),
    animationType: AnimationType.fromBottom,
    position: MotionToastPosition.bottom,
    width: 300,
    height: 80,
  ).show(context);
}




void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);

}

enum ToastStates { success, error, warning }

Color? chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.redAccent;
      break;
    case ToastStates.warning:
      color = Colors.white;
      break;
  }
  return color;
}

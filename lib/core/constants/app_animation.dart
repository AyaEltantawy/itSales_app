import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_colors.dart';

import '../themes/colors.dart';

class AppLottie {
  static var loader = CircularProgressIndicator(
    color:AppColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 100.w,vertical: 20.h),
  );
  static const nothing = 'assets/animation/nothing.json';
  static const IconData report = IconData(0xe52a, fontFamily: 'MaterialIcons');
}

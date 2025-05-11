import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_colors.dart';
import 'package:itsale/core/constants/app_icons.dart';

import '../app/app.dart';

class ForwardArrow extends StatelessWidget {
  const ForwardArrow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(
        // color: AppColors.backArrowsContainerColor,
        color: globalDark ? AppColors.cardColor.withOpacity(0.1) : AppColors.cardColorDark.withOpacity(0.03),
        // border: Border.all(color: globalDark ? AppColors.borderColorDark : AppColors.borderColor, width: 0.5),

        borderRadius: BorderRadius.circular(5.r),
      ),
      child: const Icon(AppIcons.arrowForward),


    );
  }
}

class BackwardArrow extends StatelessWidget {
  const BackwardArrow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 20.w,
      decoration: BoxDecoration(
        color: AppColors.backArrowsContainerColor,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: const Icon(AppIcons.arrowBackward),


    );
  }
}

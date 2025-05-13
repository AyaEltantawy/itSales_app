

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_colors.dart';
import 'package:itsale/core/themes/colors.dart';

import '../../../../../core/themes/styles.dart';

class ChooseContainer extends StatelessWidget {
  final String text;
final VoidCallback onTap;
  const ChooseContainer({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap,
      child: Container(decoration: BoxDecoration(color: ColorsManager.lightenestGrey,
        borderRadius: BorderRadius.circular(8.sp),
        border: Border.all(color: AppColors.primary,width: 1)



      ),

      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 30.h),
        child: Text(text,style: TextStyles.font20Weight400BaseBlack,maxLines: 2,),
      ),
      ),
    );
  }
}

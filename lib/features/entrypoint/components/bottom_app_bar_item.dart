import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/app/app.dart';
import 'package:svg_flutter/svg.dart';

import '../../../core/constants/constants.dart';
import '../../auth/data/cubit.dart';

class BottomAppBarItem extends StatelessWidget {
  const BottomAppBarItem({
    super.key,
    required this.icon,
    required this.name,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String name;
  final bool isActive;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(14.0.w),
        child: Icon(
          size: 30.sp,
          icon,
          color: AppCubit.get(context).isDarkMode
              ? AppColors.textWhite
              : AppColors.textBlack,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/app/app.dart';

import '../../../core/constants/constants.dart';
import '../../auth/data/cubit.dart';

class BottomAppBarItem extends StatelessWidget {
  const BottomAppBarItem({
    super.key,
    required this.icon,
    required this.isActive,
    required this.onTap, required this.filledIcon, required this.outlinedIcon,
  });
  final IconData filledIcon;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final IconData outlinedIcon;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppCubit.get(context).isDarkMode;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(14.0.w),
        child: Icon(
          isActive ? filledIcon : outlinedIcon,
          size: 30.sp,
          color: isActive
              ? AppColors.primary
              : (isDark ? AppColors.textWhite : AppColors.textBlack),
        ),
      ),
    );
  }
}

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
    required this.onTap,
  });

  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppCubit.get(context).isDarkMode;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(14.0.w),
        child: Icon(
          icon,
          size: 30.sp,
          color: isActive
              ? AppColors.primary
              : (isDark ? AppColors.textWhite : AppColors.textBlack),
        ),
      ),
    );
  }
}

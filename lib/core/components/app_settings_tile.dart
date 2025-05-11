import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/app/app.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:svg_flutter/svg.dart';

import '../../features/auth/data/cubit.dart';
import '../constants/app_colors.dart';
import '../constants/app_defaults.dart';

class AppSettingsListTile extends StatelessWidget {
  const AppSettingsListTile({
    super.key,
    required this.label,
    required this.style,

    this.onTap,
  required this.widget,
  });

  final String label;
  final TextStyle style;
  final Widget widget;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: AppDefaults.borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDefaults.borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 widget,
                  SizedBox(width: 10.w,),
                  Text(
                    label,
                    style: style,
                  ),
                  const Spacer(),

                ],
              ),
               Divider(thickness: 0.1, color: globalDark ? AppColors.textWhite :  AppColors.textBlack,),
            ],
          ),
        ),
      ),
    );
  }
}

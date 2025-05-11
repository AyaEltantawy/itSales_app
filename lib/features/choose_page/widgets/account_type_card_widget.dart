import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:svg_flutter/svg.dart';

class AccountTypeCard extends StatelessWidget {
  final String icon;
  final String text;
  final Color backgroundColor;
  final Color borderColor;

  const AccountTypeCard({super.key,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      padding: EdgeInsets.all(32.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Image.asset(
            icon,
            width: 70.w,
            height: 70.h,
          ),
          SizedBox(height: 10.h),
          Text(
            text,
            style: AppFonts.style20Normal,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

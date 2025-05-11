import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:svg_flutter/svg.dart';

import '../../../core/constants/constants.dart';
import '../../../generated/l10n.dart';

class LoginPageHeader extends StatelessWidget {
  const LoginPageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       // Image.asset(AppIcons.logo,
       //   height: 78.h,width: 195.w,fit: BoxFit.cover,),

SizedBox(height: 20.h,),
        Text(
          S.of(context).welcome_back,
          style: AppFonts.style36medium,
        ),
        Text(
          S.of(context).write_your_data_for_login,
          style: AppFonts.style20Light,
              ),

      ],
    );
  }
}

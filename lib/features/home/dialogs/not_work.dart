import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/components/app_buttons.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../generated/l10n.dart';

Future notWork(context) => showDialog(context: context, builder: (context) => Dialog(

  child: SizedBox(
    width: 300.w,
    height: 250.h,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context).feature_not_working, style: AppFonts.style16semiBold,),
        SizedBox(height:  30.h,),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: defaultButton(context: context, text: 'حسنا', width: 80.w, height: 40.h, isColor: true, textSize: 16.sp, toPage: ()
          {
            Navigator.pop(context);
          }),
        ),
      ],
    ),
  ),
),);

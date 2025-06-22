import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itsale/core/constants/app_animation.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/localization/app_localizations.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/l10n.dart';

Widget notFound() => Center(
  child: Lottie.asset(AppLottie.nothing,height: 170.h.h,width: 230.w.w),);

Widget nothing(context,
    {
      required String text,
      required String route,
      required String button,
    }) =>  Column(

  children: [
    SizedBox(height: 50.h,),
    notFound(),

    Text(text,style: GoogleFonts.cairo(fontSize: 20.sp,fontWeight: FontWeight.bold)),
    SizedBox(height: 20.h,),

    InkWell(
        onTap: (){
          navigateTo(context, route);
        },
        child: Container(
          height: 46.h,
        width: 240.w,
          padding: EdgeInsets.only(left:  12.w),
          decoration: BoxDecoration(
            borderRadius: AppDefaults.borderRadius,
            color: AppColors.primary,

          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add,

               color: AppColors.textWhite, size: 32,),
              SizedBox(width: 10.w,),
              Text('${AppLocalizations.of(context)!.translate("add")}$button',style: GoogleFonts.cairo(fontSize: 18.sp,fontWeight: FontWeight.bold, color: AppColors.textWhite)),
            ],
          ),
        )),


  ],
);

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/app_buttons.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/localization/app_localizations.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

String? resetToken;
String? token ;
String? role ;
String? userId ;
int? companyId;

void checkTokenAndShowLoginDialog( context) {
  if (token == null) {
    // Token is expired, show login dialog
    showLoginDialog(context);
  }
  if (JwtDecoder.isExpired(token.toString())) {
    // Token is expired, show login dialog
    showLoginDialog(context);
  } else {
    // Token is still valid
    print("Token is valid.");
  }
}

void showLoginDialog( context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        width: 200.w,
        height: 300.h,
        child: AlertDialog(


          title: Text("انتهت صلاحية الجلسة",style: AppFonts.style16semiBold,),
          content: Text("سجل دخول من جديد",style: AppFonts.style14normal,),
          actions: [
            defaultButton(context: context,
                text: AppLocalizations.of(context)!.translate("login"),
                width: 120.w,
                height: 56.h, isColor: true,
                textSize: 14.sp, toPage: ()
                {
                  navigateTo(context, AppRoutes.login);
                }),
          ],
        ),
      );
    },
  );
}

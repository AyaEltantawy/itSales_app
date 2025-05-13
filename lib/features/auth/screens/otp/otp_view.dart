import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_colors.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/components/app_buttons.dart';
import '../../../../core/constants/navigation.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/styles.dart';
import 'otp_cubit.dart';
import 'otp_state.dart';

class OtpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => OtpCubit(),
        child: Scaffold(body: SafeArea(
            child: BlocBuilder<OtpCubit, OtpState>(builder: (context, state) {
          final controller = BlocProvider.of<OtpCubit>(context);
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            children: [
              Row(
                children: [
                  Image.asset("assets/images/xicon.png"),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "رمز التحقق",
                    style: TextStyles.font20Weight500BaseBlack,
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "اكتب رمز التحقق",
                style: TextStyles.font20Weight400Black,
              ),
              Text(
                "اكتب رمز التحقق من 5 أرقام",
                style: TextStyles.font16Weight300Grey,
              ),
              SizedBox(
                height: 40.h,
              ),
              PinCodeTextField(
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                animationDuration: Duration(milliseconds: 300),
                // Pass it here
                onChanged: (value) {
                  controller.otpCode = value;
                },

                appContext: context,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  inactiveColor: ColorsManager.solidGrey,
                  activeColor: AppColors.primary,
                  selectedColor: AppColors.primary,
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 35.h,
              ),
              defaultButton(
                  context: context,
                  text: "تأكيد",
                  width: double.infinity,
                  height: 56.h,
                  isColor: true,
                  textSize: 15.sp,
                  toPage: () {navigateTo(context, AppRoutes.resetPasswordPage);}),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "01:02",
                style: TextStyles.font20Weight300Emerald,
                textAlign: TextAlign.center,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "لم تحصل على الرمز ؟ ",
                  style: TextStyles.font18Weight500Black,
                  children: [
                    TextSpan(
                      text: 'إرسال مرة أخرى',
                      style: TextStyles.font16Weight300EmeraldWithoutLine,
                    ),

                  ],
                ),
              ),
            ],
          );
        }))));
  }
}

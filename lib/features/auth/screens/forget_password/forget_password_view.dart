import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/app_buttons.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/components/app_text_form_field.dart'
    show defaultTextFormFeild;
import '../../../../core/constants/app_icons.dart';
import '../../../../core/themes/styles.dart';
import '../../../../core/utils/validators.dart';
import 'forget_password_cubit.dart';
import 'forget_password_state.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ForgetPasswordCubit(),
      child: Scaffold(body:
      SafeArea(child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        builder: (context, state) {
          final controller = BlocProvider.of<ForgetPasswordCubit>(context);
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
                    "نسيت كلمة السر",
                    style: TextStyles.font20Weight500BaseBlack,
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "برجاء كتابة البريد الإلكتروني",
                style: TextStyles.font20Weight400Black,
              ),
              Text(
                "سيتم إرسال رمز للتحقق إلى بريدك الإلكتروني",
                style: TextStyles.font16Weight300Grey,
              ),
              SizedBox(
                height: 40.h,
              ),
              defaultTextFormFeild(
                context,
                keyboardType: TextInputType.emailAddress,
                controller: controller.emailController,
                validate:
                Validators
                    .requiredWithFieldName('البريد الالكتروني')
                    .call,
                prefix: const Icon(AppIcons.email),
                label: 'اكتب البريد الالكتروني',
              ),
              SizedBox(height: 35.h,),
              defaultButton(context: context,
                  text: "إرسال رمز التأكد",
                  width: double.infinity,
                  height: 56.h,
                  isColor: true,
                  textSize: 15.sp,
                  toPage:(){navigateTo(context, AppRoutes.otpPage);} )
            ],
          );
        },
      ))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/app_text_form_field.dart';

import '../../../../core/components/app_buttons.dart';
import '../../../../core/constants/app_defaults.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/navigation.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/styles.dart' show TextStyles;
import 'reset_password_cubit.dart';
import 'reset_password_state.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ResetPasswordCubit(),
      child: Scaffold(body:
          SafeArea(child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
          final controller = BlocProvider.of<ResetPasswordCubit>(context);
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
                    "إعادة تعيين كلمة المرور",
                    style: TextStyles.font20Weight500BaseBlack,
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "اكتب كلمة المرور الجديدة",
                style: TextStyles.font20Weight400Black,
              ),
              Text(
                "تأكد من ان كلمة السر تحتوي على علامات وحروف وأرقام",
                style: TextStyles.font16Weight300Grey,
              ),
              SizedBox(
                height: 40.h,
              ),
              defaultTextFormFeild(context,
                  keyboardType: TextInputType.multiline,
                  hint: "اكتب كلمة المرور ",
                  prefix: Image.asset(
                    "assets/images/lock.png",
                  ),
                  suffix: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove_red_eye_outlined)), ),
              SizedBox(height: 20.h,),
              defaultTextFormFeild(context,
                  keyboardType: TextInputType.multiline,
                  hint: "تأكيد كلمة المرور",
                  prefix: Image.asset(
                    "assets/images/lock.png",
                  ),
                  suffix: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove_red_eye_outlined)),),
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
                  toPage: () {
                    navigateTo(context, AppRoutes.passwordChangedSuccessPage);
                  })
            ],
          );
        },
      ))),
    );
  }
}

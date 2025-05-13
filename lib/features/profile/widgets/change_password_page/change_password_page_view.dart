import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/app_buttons.dart';
import '../../../../core/components/app_text_form_field.dart';
import '../../../../core/constants/navigation.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/styles.dart';
import 'change_password_page_cubit.dart';
import 'change_password_page_state.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChangePasswordPageCubit(),
      child: Scaffold(body: SafeArea(
          child: BlocBuilder<ChangePasswordPageCubit, ChangePasswordPageState>(
        builder: (context, state) {
          final controller = BlocProvider.of<ChangePasswordPageCubit>(context);
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            children: [
              Row(
                children: [
                  Image.asset("assets/images/forward_arrow.png"),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "تعديل كلمة السر",
                    style: TextStyles.font20Weight500BaseBlack,
                  )
                ],
              ),

              SizedBox(
                height: 40.h,
              ),
              defaultTextFormFeild(
                context,
                keyboardType: TextInputType.multiline,
                hint: "اكتب كلمة المرور القديمة ",
                prefix: Image.asset(
                  "assets/images/lock.png",
                ),
                suffix: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.remove_red_eye_outlined)),
              ),
              SizedBox(
                height: 20.h,
              ),
              defaultTextFormFeild(
                context,
                keyboardType: TextInputType.multiline,
                hint: "اكتب كلمة المرور الجديدة ",
                prefix: Image.asset(
                  "assets/images/lock.png",
                ),
                suffix: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.remove_red_eye_outlined)),
              ),

              SizedBox(height: 20.h,),
              defaultTextFormFeild(
                context,
                keyboardType: TextInputType.multiline,
                hint: "تأكيد كلمة المرور",
                prefix: Image.asset(
                  "assets/images/lock.png",
                ),
                suffix: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.remove_red_eye_outlined)),
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
                  toPage: () {

                  }),
              SizedBox(height: 20.h,),
              defaultButton(
                  context: context,
                  text: "نسيت كلمة السر؟",
                  width: double.infinity,
                  height: 56.h,
                  isColor: false,
                  textSize: 15.sp,
                  toPage: () {

                  })
            ],
          );
        },
      ))),
    );
  }
}

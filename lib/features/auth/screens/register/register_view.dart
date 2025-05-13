import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/features/auth/screens/register/widgets/register_page_form.dart'
    show RegisterPageForm;

import '../../../../core/constants/app_fonts.dart';
import '../../../../core/themes/styles.dart';
import '../../components/login_header.dart';
import '../../components/login_page_form.dart';
import 'register_cubit.dart';
import 'register_state.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: Scaffold(
            body: SafeArea(child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            final controller = BlocProvider.of<RegisterCubit>(context);
            return ListView(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    'إنشاء حساب جديد',
                    style: TextStyles.font20Weight500BaseBlack,
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "مرحبا",
                          style: AppFonts.style36medium,
                        ),
                        Text(
                          "اكتب بياناتك لانشاء حساب جديد",
                          style: AppFonts.style20Light,
                        ),
                        RegisterPageForm(
                          isPasswordShown: controller.isPasswordShown,
                          onPassShowClicked: controller.onPassShowClicked,
                        ),
                      ]),
                ]);
          },
        ))));
  }
}

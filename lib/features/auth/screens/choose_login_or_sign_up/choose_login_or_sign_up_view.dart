import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/features/auth/screens/choose_login_or_sign_up/widgets/choose_container.dart';

import '../../../../core/constants/app_images.dart';
import '../../data/cubit.dart' show AppCubit;
import 'choose_login_or_sign_up_cubit.dart';
import 'choose_login_or_sign_up_state.dart';

class ChooseLoginOrSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ChooseLoginOrSignUpCubit(),
        child: Scaffold(
          body: SafeArea(
              child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50.h),
            children: [
              Image.asset(
                AppCubit.get(context).isDarkMode
                    ? AppImages.finalLogoDark
                    : AppImages.finalLogo,
                width: 150.w,
                height: 100.h,
              ),
              SizedBox(
                height: 70.h,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChooseContainer(
                      text: "تسجيل الدخول",
                      onTap: () {
                        navigateTo(context, AppRoutes.login);
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ChooseContainer(
                      text: "  إنشاء حساب \n        جديد  ",
                      onTap: () {
                        navigateTo(context, AppRoutes.registerPage);
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
        ));
  }
}

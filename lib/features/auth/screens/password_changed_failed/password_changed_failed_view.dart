import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/app_buttons.dart';
import '../../../../core/constants/navigation.dart' show navigateTo;
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/styles.dart';
import 'password_changed_failed_cubit.dart';
import 'password_changed_failed_state.dart';

class PasswordChangedFailedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => PasswordChangedFailedCubit(),
        child: Scaffold(body: SafeArea(child:
            BlocBuilder<PasswordChangedFailedCubit, PasswordChangedFailedState>(
          builder: (context, state) {
            final controller =
                BlocProvider.of<PasswordChangedFailedCubit>(context);
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              children: [
                Text(
                  "تم إعادة تعيين كلمة السر",
                  style: TextStyles.font20Weight500BaseBlack,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Image.asset(
                  "assets/images/done.png",
                  width: 172.w,
                  height: 172.w,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "تم تعيين كلمة المرور بنجاح",
                  style: TextStyles.font20Weight400Black,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "يمكنك الدخول إلى حسابك الآن ",
                  style: TextStyles.font16Weight300Grey,
                ),
                SizedBox(
                  height: 40.h,
                ),
                SizedBox(
                  height: 35.h,
                ),
                defaultButton(
                    context: context,
                    text: "الإنتقال لصفحة الدخول",
                    width: double.infinity,
                    height: 56.h,
                    isColor: true,
                    textSize: 15.sp,
                    toPage: () {
                      navigateTo(context, AppRoutes.homeEmployee);
                    })
              ],
            );
          },
        ))));
  }
}

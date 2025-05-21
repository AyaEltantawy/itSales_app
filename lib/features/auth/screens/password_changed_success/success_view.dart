import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/app_buttons.dart';
import '../../../../core/constants/navigation.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/styles.dart';
import '../../company/company_view.dart';
import 'success_cubit.dart';
import 'success_state.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => PasswordChangedSuccessCubit(),
        child: Scaffold(body: SafeArea(child: BlocBuilder<
            PasswordChangedSuccessCubit, PasswordChangedSuccessState>(
          builder: (context, state) {
            final controller =
                BlocProvider.of<PasswordChangedSuccessCubit>(context);
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              children: [
                Text(
                  "تم التسجيل بنجاح",
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
                  "تم تسجيل الدخول بنجاح",
                  style: TextStyles.font20Weight400Black,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "يمكنك انشاء شركتك الان ",
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
                    text: "انشئ شركتك الان اذا لم تملك",
                    width: double.infinity,
                    height: 56.h,
                    isColor: true,
                    textSize: 15.sp,
                    toPage: () {
                      navigateTo(context, AppRoutes.companyPage);
                    })
              ],
            );
          },
        ))));
  }
}

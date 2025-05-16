import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/constants/navigation.dart';
import 'package:itsale/features/auth/data/cubit.dart';
import 'package:itsale/features/auth/data/states.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/themes/styles.dart';
import '../components/checkbox_and_text.dart';
import '../../../core/constants/app_animation.dart';
import '../../../core/constants/app_defaults.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/snack_bar.dart';
import '../components/login_header.dart';
import '../components/login_page_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is PostErrorLoginSalesState) {
       Utils.showSnackBar(context,  'عفوا البيانات غير صحيحة');
      }

      if (state is PostSuccessLoginSalesState) {
        Utils.showSnackBar(context,'تم تسجيل الدخول بنجاح');

        navigateTo(context, AppRoutes.entryPoint);
        print('success');
      }
    }, builder: (context, state) {
      if (state is PostLoadingLoginSalesState) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'يرجى الانتظار...',
                      style: AppFonts.style20medium,
                    ),
                    AppLottie.loader,
                  ],
                ),
              ),
            ),
          ),
        );
      }

      return Scaffold(
          body: SafeArea(
              child: ListView(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  children: [
            Text(
              textAlign: TextAlign.start,
              AppLocalizations.of(context)!.translate('hi'),
              style: TextStyles.font20Weight500BaseBlack,
            ),
            const Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginPageHeader(),
                  LoginPageForm(),
                ]),
          ])));
    });
  }
}

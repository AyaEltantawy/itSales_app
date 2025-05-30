import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/constants/navigation.dart';
import 'package:itsale/core/utils/token.dart';
import 'package:itsale/features/auth/data/cubit.dart';
import 'package:itsale/features/auth/data/states.dart';

import '../../../core/cache_helper/cache_helper.dart';
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
  final TextEditingController? initialEmail;
  final TextEditingController? initialPassword;
  final int? companyId;

  LoginPage(
      {super.key, this.initialEmail, this.initialPassword, this.companyId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) async {
      if (state is PostSuccessLoginSalesState) {
        await AppCubit.get(context).getUserDataFun(context);

        final cachedCompanyId = CacheHelper.getData(key: 'company_id');
        final role = CacheHelper.getData(key: 'role');

        print("📦 Cached companyId after login: $cachedCompanyId (${cachedCompanyId.runtimeType})");
        print("👤 Role: $role (${role.runtimeType})");

        if ((cachedCompanyId == null || cachedCompanyId == '' || cachedCompanyId == 'null') &&
            role.toString() == '1') {
          print("❌ companyId is null or empty. Navigating to companyPage.");
          await navigateTo(context, AppRoutes.companyPage);
        } else {
          print("✅ companyId is valid. Navigating to entryPoint.");
          await navigateTo(context, AppRoutes.entryPoint);
        }

        Utils.showSnackBar(
          context,
          AppLocalizations.of(context)!.translate("login_done_successfuly"),
        );
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
                      AppLocalizations.of(context)!.translate("please_waiting"),
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
              AppLocalizations.of(context)!.translate('login'),
              style: TextStyles.font20Weight500BaseBlack,
            ),
            Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LoginPageHeader(),
                  LoginPageForm(
                    emailController: initialEmail,
                    passwordController: initialPassword,
                  ),
                ]),
          ])));
    });
  }
}

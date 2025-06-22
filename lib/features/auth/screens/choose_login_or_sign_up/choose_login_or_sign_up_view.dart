import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/app_buttons.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/features/auth/screens/choose_login_or_sign_up/widgets/choose_container.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/themes/styles.dart';
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
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      width: double.infinity,
                      height: 300.h,
                      child: Image.asset(
                        "assets/images/workers.png",
                        fit: BoxFit.cover,
                      )),
                  Image.asset(
                    AppCubit.get(context).isDarkMode
                        ? AppImages.finalLogoDark
                        : AppImages.finalLogo,
                    width: 150.w,
                    height: 100.h,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                AppLocalizations.of(context)!.translate("welcome_message"),

                style: TextStyles.font25WeightBoldBlack,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultButton(
                        width: double.infinity,
                        height: 56.h,
                        text: AppLocalizations.of(context)!.translate("login")
                        ,
                        textSize: 15.sp,
                        isColor: true,
                        context: context,
                        toPage: () {
                          navigateTo(context, AppRoutes.login);
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      defaultButton(
                          context: context,
                          text:AppLocalizations.of(context)!.translate("register")
                          ,
                          width: double.infinity,
                          height: 56.h,
                          isColor: true,
                          textSize: 15.sp,
                          toPage: () {
                            navigateTo(context, AppRoutes.registerPage);
                          }),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}

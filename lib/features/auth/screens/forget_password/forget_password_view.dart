import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/app_buttons.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/components/app_text_form_field.dart'
    show defaultTextFormFeild;
import '../../../../core/constants/app_icons.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/themes/styles.dart';
import '../../../../core/utils/validators.dart';
import 'forget_password_cubit.dart';
import 'forget_password_state.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgetPasswordCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
            builder: (context, state) {
              final cubit = context.read<ForgetPasswordCubit>();

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset("assets/images/xicon.png"),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            AppLocalizations.of(context)!.translate("forgot_password")
                            ,
                            style: TextStyles.font20Weight500BaseBlack,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        AppLocalizations.of(context)!.translate("please_enter_email")
                        ,
                        style: TextStyles.font20Weight400Black,
                      ),
                      Text(
                        AppLocalizations.of(context)!.translate("verification_code_notice")
,
                        style: TextStyles.font16Weight300Grey,
                      ),
                      SizedBox(height: 40.h),
                      defaultTextFormFeild(
                        context,
                        keyboardType: TextInputType.emailAddress,
                        controller: cubit.emailController,
                        validator: Validators.requiredWithFieldName(
                               AppLocalizations.of(context)!.translate("email"),context)
                            .call,
                        prefix: const Icon(AppIcons.email),
                        label:AppLocalizations.of(context)!.translate("write_email"),
                      ),
                      SizedBox(height: 35.h),
                      state is LoadingForgetPassword
                          ? Center(child: CircularProgressIndicator())
                          : defaultButton(
                              context: context,
                              text: AppLocalizations.of(context)!.translate("send_verification_code")
                        ,
                              width: double.infinity,
                              height: 56.h,
                              isColor: true,
                              textSize: 15.sp,
                              toPage: () {
                                cubit.forgetPassword(context);
                              },
                            ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

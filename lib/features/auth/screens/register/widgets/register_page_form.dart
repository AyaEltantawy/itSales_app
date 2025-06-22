import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';

import '../../../../../core/components/app_buttons.dart';
import '../../../../../core/components/app_text_form_field.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/snack_bar.dart'
    show Utils, warningMotionToast;
import '../../../../../core/utils/validators.dart';
import '../../../data/cubit.dart' show AppCubit;

class RegisterPageForm extends StatelessWidget {
  final void Function() onPassShowClicked;
  final void Function() onPassShowClickedConfirm;
  final bool isPasswordShown;
  final bool isPasswordShownConfirm;

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  final VoidCallback onSubmit;

  RegisterPageForm({
    super.key,
    required this.onPassShowClicked,
    required this.isPasswordShown,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.firstNameController,
    required this.lastNameController,
    required this.onSubmit,
    required this.isPasswordShownConfirm,
    required this.onPassShowClickedConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          defaultTextFormFeild(
            context,
            controller: firstNameController,
            validator: Validators.requiredWithFieldName(
                AppLocalizations.of(context)!.translate("first_name"),context),
            prefix: Icon(AppIcons.person_2_outlined),
            label: AppLocalizations.of(context)!.translate("first_name"),
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: 15.h),
          defaultTextFormFeild(
            keyboardType: TextInputType.name,
            context,
            controller: lastNameController,
            validator: Validators.requiredWithFieldName(AppLocalizations.of(context)!.translate("last_name")
            ,context),
            prefix: Icon(AppIcons.person_2_outlined),
            label: AppLocalizations.of(context)!.translate("last_name")
            ,
          ),
          SizedBox(height: 15.h),
          defaultTextFormFeild(
            context,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            validator: Validators.requiredWithFieldName(AppLocalizations.of(context)!.translate("email"),context),
            prefix: const Icon(AppIcons.email),
            label: AppLocalizations.of(context)!.translate("email"),
          ),
          SizedBox(height: 15.h),
          defaultTextFormFeild(
            keyboardType: TextInputType.multiline,
            context,
            controller: passwordController,
            validator: Validators.password(context),
            onSubmit: (_) => onSubmit(),
            secure: !isPasswordShown,
            prefix: const Icon(AppIcons.lock),
            label: AppLocalizations.of(context)!.translate("password")
            ,
            suffix: IconButton(
              onPressed: onPassShowClicked,
              icon: Icon(
                isPasswordShown ? AppIcons.eye : AppIcons.eyeNonVisible,
                size: 24,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          defaultTextFormFeild(
            keyboardType: TextInputType.multiline,
            context,
            controller: confirmPasswordController,
            validator: (value) {
              if (value != passwordController.text) {
                return AppLocalizations.of(context)!.translate('Password does not match');
              }
              return Validators.password(context).call(value);

            },
            onSubmit: (_) => onSubmit(),
            secure: !isPasswordShownConfirm,
            prefix: const Icon(AppIcons.lock),
            label: AppLocalizations.of(context)!.translate('password_confirmation'),
            suffix: IconButton(
              onPressed: onPassShowClickedConfirm,
              icon: Icon(
                isPasswordShownConfirm ? AppIcons.eye : AppIcons.eyeNonVisible,
                size: 24,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          defaultButton(
            context: context,
            isColor: true,
            height: 56.h,
            width: double.infinity,
            text: AppLocalizations.of(context)!.translate("register"),
            textSize: 17.sp,
            toPage: onSubmit,
          ),
        ],
      ),
    );
  }
}

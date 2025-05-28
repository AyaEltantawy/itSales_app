import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';

import '../../../../../core/components/app_buttons.dart';
import '../../../../../core/components/app_text_form_field.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/utils/snack_bar.dart' show Utils, warningMotionToast;
import '../../../../../core/utils/validators.dart';
import '../../../data/cubit.dart' show AppCubit;

class RegisterPageForm extends StatelessWidget {
  final void Function() onPassShowClicked;
  final bool isPasswordShown;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  final VoidCallback onSubmit;

  const RegisterPageForm({
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
            validator: Validators.requiredWithFieldName('الاسم الأول'),
            prefix: Icon(AppIcons.person_2_outlined),
            label: "الاسم الأول", keyboardType:TextInputType.name ,
          ),
          SizedBox(height: 15.h),
          defaultTextFormFeild(
            keyboardType:TextInputType.name ,
            context,
            controller: lastNameController,
            validator: Validators.requiredWithFieldName('الاسم الأخير'),
            prefix: Icon(AppIcons.person_2_outlined),
            label: "الاسم الأخير",
          ),
          SizedBox(height: 15.h),
          defaultTextFormFeild(
            context,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            validator: Validators.requiredWithFieldName('البريد الالكتروني'),
            prefix: const Icon(AppIcons.email),
            label: 'البريد الالكتروني',
          ),
          SizedBox(height: 15.h),
          defaultTextFormFeild(
            keyboardType: TextInputType.multiline,
            context,
            controller: passwordController,
            validator: Validators.password,
            onSubmit: (_) => onSubmit(),
            secure: !isPasswordShown,
            prefix: const Icon(AppIcons.lock),
            label: 'كلمة المرور',
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
                return 'كلمة المرور غير متطابقة';
              }
              return Validators.password(value);
            },
            onSubmit: (_) => onSubmit(),
            secure: !isPasswordShown,
            prefix: const Icon(AppIcons.lock),
            label: 'تأكيد كلمة المرور',
            suffix: IconButton(
              onPressed: onPassShowClicked,
              icon: Icon(
                isPasswordShown ? AppIcons.eye : AppIcons.eyeNonVisible,
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
            text: 'إنشاء حساب جديد',
            textSize: 17.sp,
            toPage: onSubmit,
          ),
          SizedBox(height: 20.h),
          defaultButton(
            context: context,
            text: "رجوع",
            width: double.infinity,
            height: 56.h,
            isColor: false,
            textSize: 17.sp,
            toPage: () => navigateTo(context, AppRoutes.chooseLoginOrSignUpPage),
          )
        ],
      ),
    );
  }
}

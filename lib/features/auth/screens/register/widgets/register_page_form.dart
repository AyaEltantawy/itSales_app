import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';

import '../../../../../core/components/app_buttons.dart';
import '../../../../../core/components/app_text_form_field.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/utils/toast.dart' show warningMotionToast;
import '../../../../../core/utils/validators.dart';
import '../../../data/cubit.dart' show AppCubit;

class RegisterPageForm extends StatelessWidget {
  void Function() onPassShowClicked;
  final bool isPasswordShown;

  RegisterPageForm(
      {super.key,
      required this.onPassShowClicked,
      required this.isPasswordShown});

  final _key = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    onRegister() {
      final bool isFormOkay = _key.currentState?.validate() ?? false;
      //errorMotionToast(context,text: 'البيانات غير صحيحه');

      if (isFormOkay) {
        AppCubit.get(context).postLoginSales(context,
            email: emailController.text, password: passController.text);
      } else {
        warningMotionToast(context, text: 'يرجى الالتزام بالتعليمات');
      }
    }

    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          defaultTextFormFeild(
            context,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            validate:
            Validators.requiredWithFieldName('الإسم').call,
            prefix:  Icon(AppIcons.person_2_outlined),
            label: "الإسم",
          ),
          SizedBox(height: 15.h),
          defaultTextFormFeild(
            context,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            validate:
                Validators.requiredWithFieldName('البريد الالكتروني').call,
            prefix: const Icon(AppIcons.email),
            label: 'اكتب البريد الالكتروني',
          ),
          SizedBox(height: 15.h),
          defaultTextFormFeild(
            context,
            keyboardType: TextInputType.text,
            controller: passController,
            validate: Validators.password.call,
            onSubmit: (v) => onRegister(),
            secure: !isPasswordShown,
            prefix: const Icon(AppIcons.lock),
            label: 'اكتب كلمة المرور',
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
            context,
            keyboardType: TextInputType.text,
            controller: passController,
            validate: Validators.password.call,
            onSubmit: (v) => onRegister(),
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
          SizedBox(height: 30.h,)
          ,     defaultButton(
              isColor: true,
              height: 56.h,
              width: double.infinity,
              text: 'إنشاء حساب جديد',
              context: context,
              textSize: 17.sp,
              toPage: (){navigateTo(context, AppRoutes.homeEmployee);}),

          SizedBox(
            height: 20.h,
          ),
          defaultButton(
              context: context,
              text: "رجوع",
              width: double.infinity,
              height: 56.h,
              isColor: false,
              textSize: 17.sp,
              toPage: () {navigateTo(context,AppRoutes.chooseLoginOrSignUpPage);})
        ],
      ),
    );
  }
}

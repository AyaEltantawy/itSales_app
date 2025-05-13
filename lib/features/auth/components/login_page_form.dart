import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/app_text_form_field.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:svg_flutter/svg.dart';
import '../../../core/constants/app_animation.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/app_themes.dart';
import '../../../core/utils/toast.dart';
import '../../../core/utils/validators.dart';
import '../../../core/components/app_buttons.dart';
import '../data/cubit.dart';
import '../data/states.dart';
import 'checkbox_and_text.dart' show CheckBoxAndText;
import 'login_header.dart';

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({
    super.key,
  });

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final _key = GlobalKey<FormState>();

  bool isPasswordShown = false;

  onPassShowClicked() {
    setState(() {
      isPasswordShown = !isPasswordShown;
    });
  }

  var emailController = TextEditingController();
  var passController = TextEditingController();

  onLogin() {
    final bool isFormOkay = _key.currentState?.validate() ?? false;
    //errorMotionToast(context,text: 'البيانات غير صحيحه');

    if (isFormOkay) {
      AppCubit.get(context).postLoginSales(context,
          email: emailController.text, password: passController.text);
    } else {
      warningMotionToast(context, text: 'يرجى الالتزام بالتعليمات');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                onSubmit: (v) => onLogin(),
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

              // Forget Password labelLarge
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     // Checkbox(value: true, onChanged: (value) {},
              //     //   visualDensity: const VisualDensity(
              //     //       horizontal: -4.0, vertical: -4.0),
              //     // ),
              //     // Text(
              //     //   ' تذكرنى المرة القادمة',
              //     //   style: AppFonts.style16Light,
              //     // ),
              //     // const Spacer(),
              //     // TextButton(
              //     //   style: TextButton.styleFrom(
              //     //     padding: const EdgeInsets.all(0.0),
              //     //   ),
              //     //   onPressed: () {
              //     //  //   Navigator.pushNamed(context, AppRoutes.forgotPassword);
              //     //   },
              //     //   child: Text(
              //     //     ' نسيت كلمة السر؟',
              //     //     style: AppFonts.style16LightPrimary,
              //     //   ),
              //     // ),
              //   ],
              // ),
              CheckBoxAndText(
                isChecked: cubit.isChecked,
                toggleCheckbox: cubit.toggleCheckbox,
              ),
              SizedBox(
                height: 40.h,
              ),

              defaultButton(
                  isColor: true,
                  height: 56.h,
                  width: double.infinity,
                  text: 'تسجيل الدخول',
                  context: context,
                  textSize: 17.sp,
                  toPage: onLogin),

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
      },
    );
  }
}

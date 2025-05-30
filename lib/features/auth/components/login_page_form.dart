import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/app_text_form_field.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/localization/app_localizations.dart';
import 'package:svg_flutter/svg.dart';
import '../../../core/constants/app_animation.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/app_themes.dart';
import '../../../core/utils/snack_bar.dart';
import '../../../core/utils/token.dart';
import '../../../core/utils/validators.dart';
import '../../../core/components/app_buttons.dart';
import '../data/cubit.dart';
import '../data/states.dart';
import 'checkbox_and_text.dart' show CheckBoxAndText;

class LoginPageForm extends StatefulWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  const LoginPageForm(
      {super.key, this.emailController, this.passwordController});

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final _key = GlobalKey<FormState>();
  bool isPasswordShown = false;

  late TextEditingController emailController;
  late TextEditingController passController;

  @override
  void initState() {
    super.initState();
    emailController = widget.emailController ?? TextEditingController();
    passController = widget.passwordController ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.emailController == null) {
      emailController.dispose();
    }
    if (widget.passwordController == null) {
      passController.dispose();
    }
    super.dispose();
  }

  void onPassShowClicked() {
    setState(() {
      isPasswordShown = !isPasswordShown;
    });
  }

  void onLogin(BuildContext context) async {

    final isFormOkay = _key.currentState?.validate() ?? false;

    if (isFormOkay) {
      AppCubit.get(context).postLoginSales(
        context,
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
    } else {
      Utils.showSnackBar(
        context,
        AppLocalizations.of(context)!
            .translate("Please follow the instructions."),
      );
    }

  }


@override
Widget build(BuildContext context) {
  final cubit = AppCubit.get(context);
  final local = AppLocalizations.of(context)!;

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
              validator: Validators
                  .requiredWithFieldName(
                local.translate("Please follow the instructions."),
              )
                  .call,
              prefix: const Icon(AppIcons.email),
              label: local.translate("write_email"),
            ),
            SizedBox(height: 15.h),
            defaultTextFormFeild(
              context,
              keyboardType: TextInputType.text,
              controller: passController,
              validator: Validators.password.call,
              onSubmit: (v) => onLogin(context),
              secure: !isPasswordShown,
              prefix: const Icon(AppIcons.lock),
              label: local.translate("write_password"),
              suffix: IconButton(
                onPressed: onPassShowClicked,
                icon: Icon(
                  isPasswordShown ? AppIcons.eye : AppIcons.eyeNonVisible,
                  size: 24,
                ),
              ),
            ),
            CheckBoxAndText(
              isChecked: cubit.isChecked,
              toggleCheckbox: cubit.toggleCheckbox,
            ),
            SizedBox(height: 40.h),
            defaultButton(
              isColor: true,
              height: 56.h,
              width: double.infinity,
              text: local.translate("login"),
              context: context,
              textSize: 17.sp,
              toPage: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  onLogin(context);
                });
              },
            ),
            SizedBox(height: 20.h),
            defaultButton(
              context: context,
              text: local.translate("back"),
              width: double.infinity,
              height: 56.h,
              isColor: false,
              textSize: 17.sp,
              toPage: () {
                navigateTo(context, AppRoutes.chooseLoginOrSignUpPage);
              },
            ),
          ],
        ),
      );
    },
  );
}}

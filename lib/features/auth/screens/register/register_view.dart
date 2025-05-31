import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/localization/app_localizations.dart';
import 'package:itsale/features/auth/data/repo.dart';
import 'package:itsale/features/auth/screens/register/widgets/register_page_form.dart';
import 'package:itsale/features/home/data/cubit.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/navigation.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/styles.dart';
import '../../../../core/utils/snack_bar.dart';
import '../../data/cubit.dart';
import 'register_cubit.dart';
import 'register_state.dart';

class RegisterPage extends StatelessWidget {
  final Repository repository;

  RegisterPage({required this.repository, super.key});

  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(repository),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            Utils.showSnackBar(
                context,
                AppLocalizations.of(context)!
                    .translate("sorry data is in correct"));
          }

          if (state is RegisterSuccessState) {
            Utils.showSnackBar(
                context,
                AppLocalizations.of(context)!
                    .translate("User registered successfully"));

            navigateTo(context, AppRoutes.entryPoint);
          }
        },
        builder: (context, state) {
          final controller = context.read<RegisterCubit>();

          return Scaffold(
            body: SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                children: [


                  Column(
                    children: [

                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(

                              AppLocalizations.of(context)!.translate("register"),
                              style: TextStyles.font20Weight500BaseBlack),
                          InkWell(
                            onTap: (){ navigateTo(context, AppRoutes.chooseLoginOrSignUpPage);},
                              child: Icon(Icons.arrow_forward))
                        ],
                      ),
                      SizedBox(height: 20.h),
                      RegisterPageForm(
                          formKey: controller.formKey,
                          emailController: controller.emailController,
                          passwordController: controller.passwordController,
                          confirmPasswordController: confirmPasswordController,
                          firstNameController: controller.firstNameController,
                          lastNameController: controller.lastNameController,

                          isPasswordShown: controller.isPasswordShown,
                          onPassShowClicked: controller.onPassShowClicked,
                          onSubmit: () {
                          controller.register(context);
                          }, isPasswordShownConfirm:controller.isPasswordShownConfirm, onPassShowClickedConfirm: controller.onPassShowClickedConFirm ),
                      if (state is RegisterLoadingState)
                        const CircularProgressIndicator(),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

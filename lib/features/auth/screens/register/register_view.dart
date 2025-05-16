import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          // if (state is RegisterErrorState) {
          //   Utils.showSnackBar(context, 'عفوا البيانات غير صحيحة');
          // }
          //
          // if (state is RegisterSuccessState) {
          //   Utils.showSnackBar(context, 'تم تسجيل المستخدم بنجاح');
          //   navigateTo(context, AppRoutes.entryPoint);
          // }
        },
        builder: (context, state) {
          final controller = context.read<RegisterCubit>();

          return Scaffold(
            body: SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                children: [
                  Text('إنشاء حساب جديد',
                      style: TextStyles.font20Weight500BaseBlack),
                  SizedBox(height: 80.h),
                  Column(
                    children: [
                      Text("مرحبا", style: AppFonts.style36medium),
                      Text("اكتب بياناتك لانشاء حساب جديد",
                          style: AppFonts.style20Light),
                      RegisterPageForm(
                        formKey: controller.formKey,
                        emailController: controller.emailController,
                        passwordController: controller.passwordController,
                        confirmPasswordController: confirmPasswordController,
                        firstNameController: controller.firstNameController,
                        lastNameController: controller.lastNameController,
                        timezoneController: controller.timezoneController,
                        isPasswordShown: controller.isPasswordShown,
                        onPassShowClicked: controller.onPassShowClicked,
                        onSubmit: () => EmployeeCubit.get(context).adduserFun(
                            firstName:
                                controller.firstNameController.text.toString(),
                            lastName: controller.lastNameController.text.toString(),
                            status: controller.status,
                            email: controller.emailController.text.toString(),
                            role: controller.role,
                            password: controller.passwordController.text.toString(),
                            ),
                      ),
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

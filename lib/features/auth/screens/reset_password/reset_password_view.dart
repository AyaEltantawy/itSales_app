import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/app_text_form_field.dart';

import '../../../../core/components/app_buttons.dart';
import '../../../../core/constants/navigation.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/styles.dart' show TextStyles;
import 'reset_password_cubit.dart';
import 'reset_password_state.dart';

class ResetPasswordPage extends StatefulWidget {
  final String? resetToken;

  const ResetPasswordPage({Key? key, this.resetToken}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final ValueNotifier<bool> _obscure1 = ValueNotifier(true);
  final ValueNotifier<bool> _obscure2 = ValueNotifier(true);

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    _obscure1.dispose();
    _obscure2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
            listener: (context, state) {
              if (state is LoadingSuccess) {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              } else if (state is LoadingError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<ResetPasswordCubit>();

              return Form(
                key: _formKey,
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset("assets/images/xicon.png"),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "إعادة تعيين كلمة المرور",
                          style: TextStyles.font20Weight500BaseBlack,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "اكتب كلمة المرور الجديدة",
                      style: TextStyles.font20Weight400Black,
                    ),
                    Text(
                      "تأكد من ان كلمة السر تحتوي على علامات وحروف وأرقام",
                      style: TextStyles.font16Weight300Grey,
                    ),
                    SizedBox(height: 40.h),

                    ValueListenableBuilder<bool>(
                      valueListenable: _obscure1,
                      builder: (_, obscure, __) {
                        return defaultTextFormFeild(
                          context,
                          controller: _passwordController,
                          hint: "اكتب كلمة المرور",
                          prefix: Image.asset("assets/images/lock.png"),
                          suffix: IconButton(
                            onPressed: () => _obscure1.value = !_obscure1.value,
                            icon: Icon(obscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'كلمة المرور قصيرة جداً';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                        );
                      },
                    ),

                    SizedBox(height: 20.h),

                    /// Confirm Password Field
                    ValueListenableBuilder<bool>(
                      valueListenable: _obscure2,
                      builder: (_, obscure, __) {
                        return defaultTextFormFeild(
                          context,
                          controller: _confirmController,
                          hint: "تأكيد كلمة المرور",
                          prefix: Image.asset("assets/images/lock.png"),
                          suffix: IconButton(
                            onPressed: () => _obscure2.value = !_obscure2.value,
                            icon: Icon(obscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'كلمات المرور غير متطابقة';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                        );
                      },
                    ),

                    SizedBox(height: 35.h),

                    /// Submit Button
                    defaultButton(
                      context: context,
                      text: "تأكيد",
                      width: double.infinity,
                      height: 56.h,
                      isColor: true,
                      textSize: 15.sp,
                      toPage: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.resetPassword(

                            newPassword: _passwordController.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

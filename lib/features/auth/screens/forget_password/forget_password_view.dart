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
import '../../../../core/themes/styles.dart';
import '../../../../core/utils/validators.dart';
import 'forget_password_cubit.dart';
import 'forget_password_state.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});

  final String resetUrl = "geotask.com://reset_password";

  Future<void> _launchResetUrl(BuildContext context) async {
    final Uri url = Uri.parse(resetUrl);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.inAppWebView);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يمكن فتح رابط إعادة تعيين كلمة المرور')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ أثناء محاولة فتح الرابط')),
      );
    }
  }

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
                          Image.asset("assets/images/xicon.png"),
                          SizedBox(width: 10.w),
                          Text(
                            "نسيت كلمة السر",
                            style: TextStyles.font20Weight500BaseBlack,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "برجاء كتابة البريد الإلكتروني",
                        style: TextStyles.font20Weight400Black,
                      ),
                      Text(
                        "سيتم إرسال رمز للتحقق إلى بريدك الإلكتروني",
                        style: TextStyles.font16Weight300Grey,
                      ),
                      SizedBox(height: 40.h),
                      defaultTextFormFeild(
                        context,
                        keyboardType: TextInputType.emailAddress,
                        controller: cubit.emailController,
                        validate: Validators.requiredWithFieldName('البريد الالكتروني').call,
                        prefix: const Icon(AppIcons.email),
                        label: 'اكتب البريد الالكتروني',
                      ),
                      SizedBox(height: 35.h),
                      state is LoadingForgetPassword
                          ? Center(child: CircularProgressIndicator())
                          : defaultButton(
                        context: context,
                        text: "إرسال رمز التأكد",
                        width: double.infinity,
                        height: 56.h,
                        isColor: true,
                        textSize: 15.sp,
                       toPage: () {    cubit.forgetPassword(context);},
                      ),
                      SizedBox(height: 25.h),
                      Center(
                        child: InkWell(
                          onTap: () => _launchResetUrl(context),
                          child: Text(
                            "أو اضغط هنا لإعادة تعيين كلمة المرور يدويًا",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14.sp,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
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

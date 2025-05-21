import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/app_buttons.dart';
import 'package:itsale/core/components/app_text_form_field.dart';

import '../../../core/themes/styles.dart';
import 'company_cubit.dart';
import 'company_state.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CompanyCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<CompanyCubit, CompanyState>(
            builder: (context, state) {
              final controller = BlocProvider.of<CompanyCubit>(context);
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                children: [
                  Text(
                    "شركتك",
                    style: TextStyles.font20Weight500BaseBlack,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      "assets/images/company.jpeg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      textAlign: TextAlign.start,
                      "ادخل شركتك",
                      style: TextStyles.font20Weight500BaseBlack),
                  defaultTextFormFeild(
                      controller: controller.companyController,
                      context,
                      keyboardType: TextInputType.name,
                      hint: "اكتب اسم شركتك"),
                  SizedBox(
                    height: 20.h,
                  ),
                  defaultButton(
                      context: context,
                      text: "اتمم انشاء حسابك",
                      width: double.infinity,
                      height: 56.h,
                      isColor: true,
                      textSize: 15.sp,
                      toPage: () {
                        controller.postCompany(context);
                      })
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'language_show_dialog_cubit.dart';
import 'language_show_dialog_state.dart';
import 'widgets/custom_radio_and_text.dart';
import '../../../../core/themes/styles.dart';

class LanguageShowDialogPage extends StatelessWidget {
  const LanguageShowDialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LanguageShowDialogCubit(),
      child: BlocBuilder<LanguageShowDialogCubit, LanguageShowDialogState>(
        builder: (context, state) {
          String selectedLanguage = 'arabic';
          if (state is AppLanguageChangeState) {
            selectedLanguage = state.selectedLanguage;
          } else if (state is LanguageShowDialogStateInit) {
            selectedLanguage = state.selectedLanguage;
          }

          final cubit = context.read<LanguageShowDialogCubit>();

          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: EdgeInsets.all(16.w),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Image.asset(
                      "assets/images/close_without_container.png",
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "أختر اللغة",
                    style: TextStyles.font20Weight500Primary,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.h),
                CustomCheckBoxAndText(
                  toggleLanguage: cubit.toggleLanguage,
                  selectedLanguage: selectedLanguage,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

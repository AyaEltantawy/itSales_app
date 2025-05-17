import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/features/profile/widgets/language_show_dialog/widgets/custom_radio_and_text.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/enums/language_event_type.dart';
import 'language_show_dialog_cubit.dart';
import 'language_show_dialog_state.dart';
import '../../../../core/themes/styles.dart';

class LanguageShowDialogPage extends StatelessWidget {
  const LanguageShowDialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LanguageShowDialogCubit(),
      child: BlocBuilder<LanguageShowDialogCubit, LanguageShowDialogState>(
        builder: (context, state) {
          final cubit = context.read<LanguageShowDialogCubit>();
          final selectedLanguage = state is LanguageShowDialogStateInit
              ? state.selectedLanguage
              : (state as AppLanguageChangeState).selectedLanguage;

          final List<String> labels = ["اللغة العربية", "English"];
          final List<String> values = ["arabic", "english"];

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
                    selectedLanguage == 'arabic'
                        ? "أختر اللغة"
                        : "Choose Language",
                    style: TextStyles.font20Weight500Primary,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: List.generate(2, (index) {
                    return CustomCheckBoxAndText(
                      selectedLanguage: selectedLanguage,
                      languageValue: values[index],
                      label: labels[index],
                      onLanguageChanged: (language) {
                        cubit.changeLanguage(language);

                        if (language == "arabic") {
                          cubit.appLanguageFunc(LanguageEventEnums.ArabicLanguage);
                        } else if (language == "english") {
                          cubit.appLanguageFunc(LanguageEventEnums.EnglishLanguage);
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/magic_router.dart';
import 'package:itsale/features/SplashScreen/splash_screen.dart';
import 'package:itsale/features/profile/widgets/language_show_dialog/widgets/custom_radio_and_text.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/enums/language_event_type.dart';
import 'language_show_dialog_cubit.dart';
import 'language_show_dialog_state.dart';
import '../../../../core/themes/styles.dart';
import 'widgets/restart_widget.dart';

class LanguageShowDialogPage extends StatefulWidget {
  const LanguageShowDialogPage({super.key});

  @override
  State<LanguageShowDialogPage> createState() => _LanguageShowDialogPageState();
}

class _LanguageShowDialogPageState extends State<LanguageShowDialogPage> {
  late final LanguageShowDialogCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = LanguageShowDialogCubit();
    cubit.appLanguageFunc(LanguageEventEnums.InitialLanguage);
  }

  void _restartApp(BuildContext context) {
    RestartWidget.restartApp(context);

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<LanguageShowDialogCubit, LanguageShowDialogState>(
        builder: (context, state) {
          final selectedLanguage = (state is AppLanguageChangeState)
              ? state.selectedLanguage
              : (state is LanguageShowDialogStateInit)
              ? state.selectedLanguage
              : 'arabic';

          final labels = ["اللغة العربية", "English"];
          final values = ["arabic", "english"];

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
                      onLanguageChanged: (language) async {
                        if (language == "arabic") {
                          cubit.appLanguageFunc(LanguageEventEnums.ArabicLanguage);
                        } else {
                          cubit.appLanguageFunc(LanguageEventEnums.EnglishLanguage);
                        }
                        _restartApp(context,);
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

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}

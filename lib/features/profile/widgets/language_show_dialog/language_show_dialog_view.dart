import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/custom_radio_and_text.dart';
import '../../../../core/themes/styles.dart';
import 'language_show_dialog_cubit.dart';
import 'language_show_dialog_state.dart';

class LanguageShowDialogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LanguageShowDialogCubit(),
        child: BlocBuilder< LanguageShowDialogCubit,  LanguageShowDialogState>(
          builder: (context, state) {
            final controller =BlocProvider.of<LanguageShowDialogCubit>(context);
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/close_without_container.png"),
                  Center(
                    child: Text(
                      "أختر اللغة",
                      style: TextStyles.font20Weight500Primary,
                    ),
                  ),                  SizedBox(
                    height: 20.h,
                  ),
                  CustomCheckBoxAndText(
                    toggleLanguage:controller. toggleLanguage,
                    selectedLanguage: controller.selectedLanguage,
                  )
                ],
              ),);
          },
        ));
  }
}



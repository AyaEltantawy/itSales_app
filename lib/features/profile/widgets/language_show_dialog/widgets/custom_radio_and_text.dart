import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/themes/styles.dart';

class CustomCheckBoxAndText extends StatelessWidget {
  final String selectedLanguage;
  final String languageValue;
  final String? label;
  final void Function(String) onLanguageChanged;

  const CustomCheckBoxAndText({
    Key? key,
    required this.selectedLanguage,
    required this.onLanguageChanged,

    required this.languageValue, required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Row(
      children: [
        Radio<String>(
          value: languageValue,
          groupValue: selectedLanguage,
          onChanged: (String? value) {
            if (value != null) {
              onLanguageChanged(value);
            }
          },
        ),
        SizedBox(width: 8.w),
        Text(
          label??'',
          style: TextStyles.font16Weight300Black,
        ),
      ],
    );
  }
}

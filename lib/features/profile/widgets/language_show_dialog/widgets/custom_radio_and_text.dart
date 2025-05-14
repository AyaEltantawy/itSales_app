import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/themes/styles.dart';

class CustomCheckBoxAndText extends StatelessWidget {
final String selectedLanguage;
  final void Function(String) toggleLanguage;

  const CustomCheckBoxAndText(
      {super.key,
      required this.selectedLanguage,
      required this.toggleLanguage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio<String>(
              value: 'arabic',
              groupValue: selectedLanguage,
              onChanged: (String? value) {
                if (value != null) {
                  toggleLanguage(value);
                }
              },
            ),
            Text("اللغة العربية", style: TextStyles.font16Weight300Black),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              value: 'english',
              groupValue: selectedLanguage,
              onChanged: (String? value) {
                if (value != null) {
                  toggleLanguage(value);
                }
              },
            ),
            Text("English", style: TextStyles.font16Weight300Black),
          ],
        ),
      ],
    );
  }
}

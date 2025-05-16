import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/styles.dart';

class CustomCheckBoxAndText extends StatelessWidget {
  final String selectedLanguage;
  final void Function(String) toggleLanguage;

  const CustomCheckBoxAndText({
    Key? key,
    required this.selectedLanguage,
    required this.toggleLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildLanguageRow(
          languageValue: 'arabic',
          label: "اللغة العربية",
        ),
        _buildLanguageRow(
          languageValue: 'english',
          label: "English",
        ),
      ],
    );
  }

  Widget _buildLanguageRow({
    required String languageValue,
    required String label,
  }) {
    return Row(
      children: [
        Radio<String>(
          value: languageValue,
          groupValue: selectedLanguage,
          onChanged: (String? value) {
            if (value != null) {
              toggleLanguage(value);
            }
          },
        ),
        SizedBox(width: 8.w), // spacing between radio and text
        Text(
          label,
          style: TextStyles.font16Weight300Black,
        ),
      ],
    );
  }
}

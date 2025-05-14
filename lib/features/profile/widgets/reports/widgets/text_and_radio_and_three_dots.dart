
import 'package:flutter/material.dart';

import '../../../../../core/themes/styles.dart' show TextStyles;

class TextAndRadioAndThreeDots extends StatelessWidget {
  final String selectedExportType;
  final void Function(String) toggleExportType;
  final String value;
  final String text;
  const TextAndRadioAndThreeDots({super.key, required this.selectedExportType, required this.toggleExportType, required this.value, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Image.asset("assets/images/tabler_dots.png"),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text, style: TextStyles.font16Weight300Black),
            Radio<String>(
              value: value,
              groupValue: selectedExportType,
              onChanged: (String? value) {
                if (value != null) {
                  toggleExportType(value);
                }
              },
            ),

          ],
        ),



    ],);
  }
}

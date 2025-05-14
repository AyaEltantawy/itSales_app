
import 'package:flutter/material.dart';

import '../../../../../core/themes/styles.dart' show TextStyles;

class TextAndNumber extends StatelessWidget {
  final String text;
  final String numberText;
  const TextAndNumber({super.key, required this.text, required this.numberText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(text,style: TextStyles.font14Weight500FifthGrey,),
    Text(numberText,style: TextStyles.font20Weight500Primary,)

      ],
    );
  }
}

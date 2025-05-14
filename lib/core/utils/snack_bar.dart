import 'package:flutter/material.dart';
import 'package:itsale/core/constants/app_colors.dart';

import '../themes/styles.dart';


class Utils {

  static void showSnackBar(BuildContext context, String msg, ) {
    final snackBar = SnackBar(

      backgroundColor: AppColors.primary,
      content: Text(
        msg,
        style: TextStyles.font20Weight500White,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
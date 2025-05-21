import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_colors.dart';
import 'package:itsale/core/localization/app_localizations.dart';

import '../../../core/routes/app_routes.dart' show AppRoutes;
import '../../../core/themes/styles.dart';

class CheckBoxAndText extends StatelessWidget {
  final bool isChecked;
  void Function() toggleCheckbox;

  CheckBoxAndText({
    super.key,
    required this.isChecked,
    required this.toggleCheckbox,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 50.w,
                  height: 50.w,
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    controlAffinity: ListTileControlAffinity.leading,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    value: isChecked,
                    onChanged: (value) => toggleCheckbox(),
                    activeColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary, width: 1),
                  ),
                ),
                Text(
                    maxLines: 2,
                    AppLocalizations.of(context)!.translate("Remember me"),
                    style: TextStyles.font16Weight300Black),
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            InkWell(
              child: Text(
                AppLocalizations.of(context)!.translate("forget_password"),
                style: TextStyles.font16Weight300Emerald,
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.forgotPassword);
              },
            )
          ],
        ),
      ],
    );
  }
}

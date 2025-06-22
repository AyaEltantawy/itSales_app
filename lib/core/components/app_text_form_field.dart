import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_colors.dart';
import 'package:itsale/core/app/app.dart';

import '../localization/app_localizations.dart'; // for globalDark

Widget defaultTextFormFeild(
    BuildContext context, {
      required TextInputType keyboardType,
      String? Function(String?)? validator,
      String? hint,
      String? label,
      String? initial,
      bool secure = false,
      bool readOnly = false,
      FocusNode? focusNode,
      void Function()? onTap,
      void Function(String)? onSubmit,
      void Function(String)? onChanged,
      Widget? prefix,
      Widget? suffix,
      TextEditingController? controller,
      bool? enabled,
      TextDirection? textDirection,
    }) {
  return TextFormField(
    key: UniqueKey(),
    controller: controller,
    initialValue: controller == null ? initial : null,
    obscureText: secure,
    readOnly: readOnly,
    focusNode: focusNode,
    onTap: onTap,
    onFieldSubmitted: onSubmit,
    onChanged: onChanged,
    keyboardType: keyboardType,
    validator: validator ??
            (value) {
          if (value == null || value.trim().isEmpty) {
            return AppLocalizations.of(context)!.translate("field_required")
            ;
          }
          return null;
        },
    enabled: enabled ?? true,
    textDirection: textDirection ?? TextDirection.rtl,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      hintText: hint,
      labelText: label,
      prefixIcon: prefix ??
          Icon(
            Icons.add,
            color: globalDark ? AppColors.textBlack : AppColors.textWhite,
          ),
      suffixIcon: suffix ??
          Icon(
            Icons.add,
            color: globalDark ? AppColors.textBlack : AppColors.textWhite,
          ),
      labelStyle: TextStyle(
        fontSize: 16.sp,
        color: AppColors.placeholder,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.placeholder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.errorColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.placeholder),
        gapPadding: 2,
      ),
      errorStyle: const TextStyle(height: 1),
      alignLabelWithHint: true,
    ),
  );
}

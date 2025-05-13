import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/app/app.dart';
import 'package:itsale/core/constants/app_colors.dart';

Widget defaultTextFormFeild(context,
    {
      required TextInputType keyboardType,
       String? Function(String?)? validate,
      String? hint,
       String? label,


      bool secure = false,
      bool readOnly = false,
      FocusNode? focusNode,
      void Function()? onTap,
      void Function(String)? onSubmit,
      void Function(String)? onChanged,
      Widget? prefix,
      Widget? suffix,
      //  double? width ,

      TextEditingController?  controller,
      bool? enabled ,
    }) =>

    TextFormField(

textDirection: TextDirection.rtl,
      readOnly: readOnly  ,
      focusNode: focusNode,
      controller: controller,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: secure,
      keyboardType: keyboardType,
      validator: validate,
      enabled: enabled != null ? enabled : true,
      decoration: InputDecoration(
        focusColor: AppColors.placeholder,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide:  BorderSide(
              color: AppColors.placeholder,
              style: BorderStyle.solid,


            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const  BorderSide(
              color: AppColors.primary,
              style: BorderStyle.solid,
              width: 2,


            )) ,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: AppColors.errorColor,
              style: BorderStyle.solid,


            )),
       // fillColor: AppColors.primary,
        errorStyle: const TextStyle(height: 1),

        // constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 18 ),
        contentPadding:
         EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        border: OutlineInputBorder(

          gapPadding: 2,

          borderSide: BorderSide(color: AppColors.placeholder,

          ),

          borderRadius: BorderRadius.circular(8.r),
        ),

        hintText: hint,
        labelText: label,
        prefixIcon: prefix != null ?
        prefix : Icon(Icons.add,color:  globalDark ? AppColors.textBlack : AppColors.textWhite,) ,
        suffixIcon: suffix != null ?
        suffix : Icon(Icons.add,color: globalDark ? AppColors.textBlack : AppColors.textWhite,) ,
        alignLabelWithHint: true,

        labelStyle: TextStyle(
          fontSize: 16.sp,
          color:  AppColors.placeholder,

        ),
      ),
    );
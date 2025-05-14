import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/app/app.dart';
import 'package:itsale/core/constants/app_colors.dart';
import 'package:itsale/core/constants/app_defaults.dart';
import 'package:itsale/core/constants/app_fonts.dart';

PreferredSizeWidget appBarDefaultTheme(
    {
      required BuildContext context,
      required bool isReverse  ,
      required String title,
      List<Widget>? actions,

    }) => AppBar(
  titleSpacing: 0.0,
  elevation: 0.0,
  centerTitle: false,

  titleTextStyle: AppFonts.style16semiBold,

  backgroundColor: AppColors.textWhite,

  leading: isReverse  ? IconButton(
    icon:
    Container(
        decoration: BoxDecoration(
          borderRadius: AppDefaults.borderRadius,
          color: AppColors.placeholder,
        ),
        child: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
    onPressed: (){
      Navigator.pop(context);
    },
  )
      : Container() ,
  title: Text(title,  textAlign: TextAlign.center,
    style: AppFonts.style20Bold,),

  actions: actions,


);


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
   const CustomAppBar({super.key, required this.back , required this.title , this.actions});
  final bool back ;
   final List<Widget>? actions;
   final String title;
  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(

      foregroundColor: AppColors.textWhite,
      surfaceTintColor: AppColors.textWhite,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      titleSpacing: 0.0,
      leadingWidth: back ? 50.w : 0.w,
      leading: back ? IconButton(
        padding: EdgeInsets.zero,
        icon: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Container(
              height: 36.h,
              width: 36.w,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
               color: globalDark ? AppColors.borderColorDark : AppColors.backArrowsContainerColor ,
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color:  globalDark ?
                AppColors.textWhite : AppColors.textBlack,
                size: 22,
              )),
        ),
        onPressed: (){
          Navigator.pop(context);
          // ClinicCubit.get(context).clearData();
        },
      )
          : Container(),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: AppFonts.style18medium,
      ),
      actions: actions,
    );

  }
}

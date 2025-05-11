import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_colors.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import 'package:itsale/features/home/data/cubit.dart';
import 'package:svg_flutter/svg.dart';

import '../../../core/app/app.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/utils/token.dart';
import '../dialogs/product_filters_dialog.dart';


class BuildSearchFilter extends StatefulWidget

{

   final bool isGrid;
   final bool emp;
   final bool task;
   final bool admin;
   final VoidCallback toggleViewMode;

  const BuildSearchFilter({super.key,
     required this.isGrid,
     required this.emp,
     required this.task,
     required this.admin,
     required this.toggleViewMode,});

  @override
  State<BuildSearchFilter> createState() => _BuildSearchFilterState();
}

class _BuildSearchFilterState extends State<BuildSearchFilter> {

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return widget.task ? const FilterDialog() : RoleDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [


          Container(
            height: 40.h,
            width: widget.admin ? 328.w : (widget.emp || role == '3' ? 250.w : 220.w),
            decoration: BoxDecoration(
              color: globalDark ? AppColors.cardColorDark : AppColors.cardColor,
              border: Border.all(color: globalDark ? AppColors.borderColorDark : AppColors.borderColor, width: 0.5),
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            child: TextFormField(
textDirection: TextDirection.rtl,
              onFieldSubmitted: (value) {
                widget.task ?
                (role == '1' ? TasksCubit.get(context).getAllTasksFunWithFilter(text: value)
                    : TasksCubit.get(context).getAllTasksFunWithFilter(textEmp: value, employee: userId) )
            : EmployeeCubit.get(context).getAdmins(search:  value.toString());

              },
             onChanged: (value) {
               widget.task ?
               (role == '1' ?
               TasksCubit.get(context).getAllTasksFunWithFilter(text: value)
                   : TasksCubit.get(context).getAllTasksFunWithFilter(textEmp: value, employee: userId) )                 :  EmployeeCubit.get(context).getAdmins(search:  value.toString());

             },
              decoration: InputDecoration(

                border: UnderlineInputBorder(borderSide:
                BorderSide(color: globalDark ? AppColors.textBlack : AppColors.textWhite  )),
                enabledBorder:  UnderlineInputBorder(borderSide:
                BorderSide(color: globalDark ? AppColors.textBlack : AppColors.textWhite)),

                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppIcons.searchIcon),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                prefixIconConstraints:
                const  BoxConstraints(minWidth: 20,minHeight: 20),
                labelText: 'ابحث هنا ',
                labelStyle: AppFonts.style14normal,
              ),
            ),
          ),
          widget.emp ?  const  Spacer() : SizedBox(width: 10.w,),
          widget.admin ? Container() : role == '3' ? Container(width: 10.w,) : InkWell(
            onTap: () {
              _showFilterDialog(context);
            },
            child:
    Container(
    width: 42.w,
    height: 42.h,
    padding: EdgeInsets.all(8.w),
    decoration: BoxDecoration(
    color: AppColors.primary,
    borderRadius: BorderRadius.circular(8)
    ),
    child:
            SvgPicture.asset(
              AppIcons.filterIcon,
              colorFilter: ColorFilter.mode( AppColors.textWhite, BlendMode.srcIn),
              width: 40.w,
              height: 40.h,
            ),
          ) ,
          ),
          widget.emp ? Container() : SizedBox(width: 8.w,),

          widget.emp ? Container() : widget.isGrid ? InkWell(
            onTap: widget.toggleViewMode,
            child: Container(
              width: 42.w,
              height: 42.h,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.backArrowsContainerColor,
                borderRadius: BorderRadius.circular(8)
              ),
              child: SvgPicture.asset(
                AppIcons.list,
                width: 20.w,
                height: 20.h,
              ),
            ),
          ) : InkWell(
            onTap: widget.toggleViewMode,
   child: Container(
    width: 42.w,
    height: 42.h,
    padding: EdgeInsets.all(8.w),
    decoration: BoxDecoration(
    color: globalDark ? AppColors.lightGreenColor : AppColors.backArrowsContainerColor,
    borderRadius: BorderRadius.circular(8)
    ),
    child: SvgPicture.asset(
              AppIcons.shapeIcon,
      colorFilter: ColorFilter.mode( AppColors.textBlack, BlendMode.srcIn),

      width: 40.w,
              height: 40.h,
            ),
          ),
          ),
      ],
    );
  }
}





Widget addEmployee(String text, TextStyle style , Color color) {
  return Container(
    width: 120.w,
    height: 30.h,
    decoration: BoxDecoration(
      color: globalDark ? AppColors.cardColorDark : AppColors.textWhite,
      borderRadius: BorderRadius.circular(5.r),
      border: Border.all(color: color),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: color,

          ),
          Expanded(
              child: Text(
                '  إضافة $text',
                style: style,
              )),

        ],
      ),
    ),
  );
}

Widget buildTitle() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [

      Text(
        'ترتيب جسب الحالة',
        style: AppFonts.style12light,
      ),
      SvgPicture.asset(
        AppIcons.belowArrowIcon,
        width: 24.w,
        height: 24.h,
      ),
    ],
  );
}

Widget buildTaskList() {
  return ListView(
    children: [
      _buildTaskCard(
        statusColor: const Color(0xff03af5d),
        statusText: 'مكتمل',
        taskDate: 'تاريخ الإكتمال\n2024-05-01 10:50 Pm',

      ),
      SizedBox(height: 24.h),
      _buildTaskCard(
        statusColor: const Color(0xffff9c33),
        statusText: 'قيد العمل',
        taskDate: 'تاريخ البدء\n2024-05-01 10:50 Pm',

      ),
      SizedBox(height: 24.h),
      _buildTaskCard(
        statusColor: const Color(0xffccd8e6),
        statusText: 'نشط',
        taskDate: 'تاريخ الانشاء\n2024-05-01 10:50 Pm',
      ),
      SizedBox(height: 24.h),
      _buildTaskCard(
        statusColor: const Color(0xfffbdadd),
        statusText: 'ملغى',
        taskDate: 'تاريخ الالغاء\n2024-05-01 10:50 Pm',
      ),
    ],
  );
}

Widget _buildTaskCard({
  required Color statusColor,
  required String statusText,
  required String taskDate,

}) {
  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: AppColors.textWhite,
      borderRadius: BorderRadius.circular(5.r),
      border: Border.all(color: const Color(0xff848a90)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              './assets/mingcute-more-2-fill.svg',
              width: 16.w,
              height: 16.h,
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: Text(
                statusText,
                style: AppFonts.style12light
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          'اسم المهمة يوضع هنا',
          style: AppFonts.style14normal,
          textAlign: TextAlign.right,
        ),
        SizedBox(height: 8.h),
        Text(
          'هنا توضع الملاحظات المهمة للغاية ',
          style: AppFonts.style12colored,
          textAlign: TextAlign.right,
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(
              taskDate,
              style: AppFonts.style12light,
            ),
          const  Spacer(),
            Icon(Icons.location_on_outlined,
              size: 14.w,

            ),
            SizedBox(width: 4.w),
            Text(
              'الفيوم نجع الكتاكيت',
              style: AppFonts.style12light,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/utils/toast.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import 'package:itsale/features/auth/data/cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/utils/token.dart';
import '../../components/button_widget.dart';

class ConfirmTaskCardList extends StatelessWidget {
  final Color statusColor;
  final String statusText;
  final String taskName;
  final String taskNotes;
  final String date;
  final String textDate;
  final String location;
  final int id;
  final int index;

  const ConfirmTaskCardList({super.key,
    required this.statusColor,
    required this.statusText,
    required this.taskName,
    required this.taskNotes,
    required this.date,
    required this.textDate,
    required this.location, required this.id, required this.index,
  });

  @override
  Widget build(BuildContext context) {
var cubit = TasksCubit.get(context).getUserTaskListWithStatus![index];
    switch(statusText) {
      case 'inbox' :
        return Container(
          margin:  EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.placeholder),
            borderRadius: BorderRadius.circular(5.r),

          ),
          child: Padding(
            padding:   EdgeInsets.only(left: 8.0.h,right: 8.w,top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(

                      children: [
                        // Padding(
                        //   padding:  EdgeInsets.only(right: 8.0.w,left: 10.0.w),
                        //   child: Container(
                        //     height: 20.h,
                        //     width: 20.w,
                        //     decoration: BoxDecoration(
                        //       color: AppColors.gray,
                        //       borderRadius: BorderRadius.circular(5.r),
                        //     ),
                        //   ),
                        // ),

                        Text('${AppCubit.get(context).getInfo!.first_name.toString()} ${AppCubit.get(context).getInfo!.last_name.toString()}',style: AppFonts.style12light,),


                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Text(
                        'قيد الانتظار',
                        style: AppFonts.style12bold.copyWith(color: AppColors.warning),
                      ),
                    ),
                    // const Icon(Icons.more_vert),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  taskName,
                  style: AppFonts.style14normalBlack,
                ),
                SizedBox(height: 8.h),
                Text(
                  taskNotes,
                  style: AppFonts.style12light,
                ),
                SizedBox(height: 8.h),


                Row(
                  children: [
                     Icon(Icons.location_on_outlined,),
                   SizedBox(width: 4.h),
                    Flexible(
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        location,
                        style: AppFonts.style12light,
                      ),
                    ),

                   const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textDate,
                          style: AppFonts.style12light,
                        ),
                        Text(
                          date,
                          style: AppFonts.style12lightGrey,
                        ),
                        SizedBox(height: 10.h,),
                      ],
                    ),
                  ],
                ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    // CustomButton(
                    //   color: AppColors.textWhite,
                    //   text: 'تأجيل الاستلام',
                    //   textColor: AppColors.primary,
                    //   borderColor: AppColors.primary,
                    // ),

                    InkWell(
                      onTap: ()
                      {
                        TasksCubit.get(context).editTaskFun(
                          taskId: id.toString(),
                          task_status: 'progress',
                        status: 'published',
                          title: cubit.title.toString(),
                          notes: cubit.notes.toString(),
                          assigned_to: cubit.assigned_to!.id.toString(),
                          description: cubit.description.toString(),
                          locationId: cubit.location?.id!.toInt(),
                          client_phone: cubit.client_phone.toString(),
                          client_name: cubit.client_name.toString(),
                          due_date: cubit.due_date.toString(),
                          start_date: cubit.start_date ?? cubit.due_date.toString(),

                        );
                      },
                      child:  CustomButton(
                        color: AppColors.primary,
                      
                        text: 'تأكيد الاستلام',
                        textColor: AppColors.textWhite,
                        borderColor: AppColors.primary,
                      ),
                    ),

                  ],
                ),


                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      case 'progress' :
        return Container(
          margin:  EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.placeholder),
            borderRadius: BorderRadius.circular(5.r),

          ),
          child: Padding(
            padding:   EdgeInsets.only(left: 8.0.h,right: 8.w,top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(

                      children: [
                        Padding(
                          padding:  EdgeInsets.only(right: 8.0.w,left: 10.0.w),
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: AppColors.gray,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        ),

                        Text('${AppCubit.get(context).getInfo!.first_name.toString()} ${AppCubit.get(context).getInfo!.last_name.toString()}',style: AppFonts.style12light,),


                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: AppColors.progress,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        'تم الاستلام',
                        style: AppFonts.style12light,
                      ),
                    ),
                    //  Icon(Icons.more_vert),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  taskName,
                  style: AppFonts.style14normalBlack,
                ),
                SizedBox(height: 8.h),
                Text(
                  taskNotes,
                  style: AppFonts.style12light,
                ),
                SizedBox(height: 8.h),


                Row(
                  children: [
                     Icon(Icons.location_on_outlined,color: AppColors.textBlack,),
                    SizedBox(width: 4.h),
                    Text(
                      location,
                      style: AppFonts.style12light,
                    ),

                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textDate,
                          style: AppFonts.style12light,
                        ),
                        Text(
                          date,
                          style: AppFonts.style12lightGrey,
                        ),
                        SizedBox(height: 10.h,),
                      ],
                    ),
                  ],
                ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    // CustomButton(
                    //   color: AppColors.textWhite,
                    //   text: 'تأجيل الاستلام',
                    //   textColor: AppColors.primary,
                    //   borderColor: AppColors.primary,
                    // ),

                    CustomButton(
                      color: AppColors.primary,

                      text: 'تأكيد الاستلام',
                      textColor: AppColors.textWhite,
                      borderColor: AppColors.primary,
                    ),

                  ],
                ),


                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      case 'cancelled' :
        return Container(
          margin:  EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.placeholder),
            borderRadius: BorderRadius.circular(5.r),

          ),
          child: Padding(
            padding:   EdgeInsets.only(left: 8.0.h,right: 8.w,top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(

                      children: [
                        Padding(
                          padding:  EdgeInsets.only(right: 8.0.w,left: 10.0.w),
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: AppColors.gray,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        ),

                        Text('${AppCubit.get(context).getInfo!.first_name.toString()} ${AppCubit.get(context).getInfo!.last_name.toString()}',style: AppFonts.style12light,),


                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: AppColors.canceled,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        'ملغي',
                        style: AppFonts.style12light,
                      ),
                    ),
                    //  Icon(Icons.more_vert),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  taskName,
                  style: AppFonts.style14normalBlack,
                ),
                SizedBox(height: 8.h),
                Text(
                  taskNotes,
                  style: AppFonts.style12light,
                ),
                SizedBox(height: 8.h),


                Row(
                  children: [
                     Icon(Icons.location_on_outlined,color: AppColors.textBlack,),
                    SizedBox(width: 4.h),
                    Text(
                      location,
                      style: AppFonts.style12light,
                    ),

                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textDate,
                          style: AppFonts.style12light,
                        ),
                        Text(
                          date,
                          style: AppFonts.style12lightGrey,
                        ),
                        SizedBox(height: 10.h,),
                      ],
                    ),
                  ],
                ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    // CustomButton(
                    //   color: AppColors.textWhite,
                    //   text: 'تأجيل الاستلام',
                    //   textColor: AppColors.primary,
                    //   borderColor: AppColors.primary,
                    // ),

                    CustomButton(
                      color: AppColors.primary,
                      text: 'تأكيد الاستلام',
                      textColor: AppColors.textWhite,
                      borderColor: AppColors.primary,
                    ),

                  ],
                ),


                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      case 'completed' :
        return Container(
          margin:  EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.placeholder),
            borderRadius: BorderRadius.circular(5.r),

          ),
          child: Padding(
            padding:   EdgeInsets.only(left: 8.0.h,right: 8.w,top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(

                      children: [
                        Padding(
                          padding:  EdgeInsets.only(right: 8.0.w,left: 10.0.w),
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: AppColors.gray,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        ),

                        Text('${AppCubit.get(context).getInfo!.first_name.toString()} ${AppCubit.get(context).getInfo!.last_name.toString()}',style: AppFonts.style12light,),


                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        'مكتمل',
                        style: AppFonts.style12lightWhite,
                      ),
                    ),
                    //  Icon(Icons.more_vert),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  taskName,
                  style: AppFonts.style14normalBlack,
                ),
                SizedBox(height: 8.h),
                Text(
                  taskNotes,
                  style: AppFonts.style12light,
                ),
                SizedBox(height: 8.h),


                Row(
                  children: [
                     Icon(Icons.location_on_outlined,color: AppColors.textBlack,),
                    SizedBox(width: 4.h),
                    Text(
                      location,
                      style: AppFonts.style12light,
                    ),

                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textDate,
                          style: AppFonts.style12light,
                        ),
                        Text(
                          date,
                          style: AppFonts.style12lightGrey,
                        ),
                        SizedBox(height: 10.h,),
                      ],
                    ),
                  ],
                ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    // CustomButton(
                    //   color: AppColors.textWhite,
                    //   text: 'تأجيل الاستلام',
                    //   textColor: AppColors.primary,
                    //   borderColor: AppColors.primary,
                    // ),

                    CustomButton(
                      color: AppColors.primary,

                      text: 'تأكيد الاستلام',
                      textColor: AppColors.textWhite,
                      borderColor: AppColors.primary,
                    ),

                  ],
                ),


                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      default :
        return Container(
          margin:  EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.placeholder),
            borderRadius: BorderRadius.circular(5.r),

          ),
          child: Padding(
            padding:   EdgeInsets.only(left: 8.0.h,right: 8.w,top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(

                      children: [
                        Padding(
                          padding:  EdgeInsets.only(right: 8.0.w,left: 10.0.w),
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: AppColors.gray,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        ),

                        Text('${AppCubit.get(context).getInfo!.first_name.toString()} ${AppCubit.get(context).getInfo!.last_name.toString()}',style: AppFonts.style12light,),


                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: AppColors.inbox,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        'قيد الانتظار',
                        style: AppFonts.style12light,
                      ),
                    ),
                    //  Icon(Icons.more_vert),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  taskName,
                  style: AppFonts.style14normalBlack,
                ),
                SizedBox(height: 8.h),
                Text(
                  taskNotes,
                  style: AppFonts.style12light,
                ),
                SizedBox(height: 8.h),


                Row(
                  children: [
                     Icon(Icons.location_on_outlined,color: AppColors.textBlack,),
                    SizedBox(width: 4.h),
                    Text(
                      location,
                      style: AppFonts.style12light,
                    ),

                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textDate,
                          style: AppFonts.style12light,
                        ),
                        Text(
                          date,
                          style: AppFonts.style12lightGrey,
                        ),
                        SizedBox(height: 10.h,),
                      ],
                    ),
                  ],
                ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    // CustomButton(
                    //   color: AppColors.textWhite,
                    //   text: 'تأجيل الاستلام',
                    //   textColor: AppColors.primary,
                    //   borderColor: AppColors.primary,
                    // ),

                    CustomButton(
                      color: AppColors.primary,

                      text: 'تأكيد الاستلام',
                      textColor: AppColors.textWhite,
                      borderColor: AppColors.primary,
                    ),

                  ],
                ),


                SizedBox(height: 10.h),
              ],
            ),
          ),
        );

    }
  }
}
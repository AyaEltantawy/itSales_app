import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import '../../../core/app/app.dart';
import '../../../core/components/network_image.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_defaults.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/utils/token.dart';
import '../../auth/data/cubit.dart';

class TaskCardList extends StatelessWidget {
  final Color statusColor;
  final String statusText;
  final String taskName;
  final String taskNotes;
  final int index;
  final String textDate;
  final String location;
  final String? completeDate;
 final  String? progressDate;
  final String? createDate;
  final String? cancelDate;
  final String names;
  final String avatar;
  final  bool?  search  ;
  final  bool?  detailsUser  ;

  const TaskCardList({super.key,
    required this.statusColor,
    required this.avatar,
    this.search,
    this.cancelDate,
    this.completeDate,
    this.progressDate,
    this.createDate,
    required this.statusText,
    required this.taskName,
    required this.taskNotes,
    required this.index,
    required this.textDate,
    required this.location,
    required this.names, this.detailsUser,
  });

  @override
  Widget build(BuildContext context) {
    var cubit =  TasksCubit.get(context);
    switch(statusText)
    {
      case 'inbox' :
        return Container(
          margin:  EdgeInsets.symmetric(vertical: 8.h),
          padding: const EdgeInsets.all(AppDefaults.padding / 2),
          decoration: BoxDecoration(
            color: globalDark ? AppColors.cardColorDark : AppColors.cardColor,
            border: Border.all(color: globalDark ? AppColors.borderColorDark : AppColors.borderColor, width: 0.5),
            borderRadius: BorderRadius.circular(8.0.r),
          ),
          child: Padding(
            padding:   EdgeInsets.only(left: 8.0.h,right: 8.w,top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          avatar != 'null' ? Container(
                              margin: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),

                              ),
                              height: 30.h,
                              width: 30.w,
                              child: NetworkImageWithLoader(
                                  borderRadius: BorderRadius.circular(5.r),
                                  avatar.toString())) :   Padding(
                            padding:  EdgeInsets.only(right: 2.0.w,left: 10.0.w),
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                color: AppColors.gray,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                          ),

                          Flexible(
                            child:
                            role == "3" ? Text('${AppCubit.get(context).getInfoLogin!.first_name} ${AppCubit.get(context).getInfoLogin!.last_name}',
                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ) :
                            Text(
                              names,

                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Text(
                        'قيد الإنتظار',
                        style: AppFonts.style12bold.copyWith(color: AppColors.warning),

                      ),
                    ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                           Icon(
                             Icons.location_on_outlined,

                               color: globalDark ? AppColors.placeholder
                                   : AppColors.textBlack
                           ),
                          SizedBox(width: 4.h),
                          Flexible(
                            child: Text(
                              location,
                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),


                    SizedBox(width: 10.w,),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                       search != null ? Container():    Text(
                            'تاريخ الانشاء',
                            style: AppFonts.style12light,
                          ),
                          search != null ? Container():   Text(
                            detailsUser != null ?
                            createDate.toString() :
                            cubit.getAllTaskList![index].created_on.toString(),
                            style: AppFonts.style10lightGrey,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.h,),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      case 'progress' :
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          padding: const EdgeInsets.all(AppDefaults.padding / 2),
          decoration: BoxDecoration(
            color: globalDark ? AppColors.cardColorDark : AppColors.cardColor,
            border: Border.all(color: globalDark ? AppColors.borderColorDark : AppColors.borderColor, width: 0.5),
            borderRadius: BorderRadius.circular(8.0.r),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 8.0.h,right: 8.w,top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          avatar != 'null' ? Container(
                              margin: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),

                              ),
                              height: 30.h,
                              width: 30.w,
                              child: NetworkImageWithLoader(
                                  borderRadius: BorderRadius.circular(5.r),
                                  avatar.toString())) :   Padding(
                            padding:  EdgeInsets.only(right: 2.0.w,left: 10.0.w),
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                color: AppColors.gray,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                          ),

                          Flexible(
                            child:
                            role == "3" ? Text('${AppCubit.get(context).getInfoLogin!.first_name} ${AppCubit.get(context).getInfoLogin!.last_name}',
                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ) :
                            Text(
                              names,

                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'تم الإستلام',
                        style: AppFonts.style12bold.copyWith(color: AppColors.info),
                      ),
                    ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                           Icon(
                             Icons.location_on_outlined,
                             color: globalDark ? AppColors.placeholder
                                 : AppColors.textBlack),
                          SizedBox(width: 4.h),
                          Flexible(
                            child: Text(
                              location,
                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),


                    SizedBox(width: 10.w,),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          search != null ? Container(): Text(
                            'تاريخ الاستلام',
                            style: AppFonts.style12light,
                          ),
                          search != null ? Container(): Text(
                            detailsUser != null ?
                            progressDate.toString() :
                            cubit.getAllTaskList![index].modified_on.toString(),
                            style: AppFonts.style10lightGrey,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.h,),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      case 'cancelled' :
        return Container(
          margin:  EdgeInsets.symmetric(vertical: 8.h),
          padding: const EdgeInsets.all(AppDefaults.padding / 2),
          decoration: BoxDecoration(
            color: globalDark ? AppColors.cardColorDark : AppColors.cardColor,
            border: Border.all(color: globalDark ? AppColors.borderColorDark : AppColors.borderColor, width: 0.5),
            borderRadius: BorderRadius.circular(8.0.r),
          ),
          child: Padding(
            padding:   EdgeInsets.only(left: 8.0.h,right: 8.w,top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          avatar != 'null' ? Container(
                              margin: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),

                              ),
                              height: 30.h,
                              width: 30.w,
                              child: NetworkImageWithLoader(
                                  borderRadius: BorderRadius.circular(5.r),
                                  avatar.toString())) :   Padding(
                            padding:  EdgeInsets.only(right: 2.0.w,left: 10.0.w),
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                color: AppColors.gray,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                          ),

                          Flexible(
                            child:
                            role == "3" ? Text('${AppCubit.get(context).getInfoLogin!.first_name} ${AppCubit.get(context).getInfoLogin!.last_name}',
                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ) :
                            Text(
                              names,

                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.danger.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'ملغي',
                        style: AppFonts.style12bold.copyWith(color: AppColors.danger),

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                           Icon(Icons.location_on_outlined,
                             color: globalDark ? AppColors.placeholder
                                 : AppColors.textBlack),
                          SizedBox(width: 4.h),
                          Flexible(
                            child: Text(
                              location,
                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),


                    SizedBox(width: 10.w,),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          search != null ? Container():    Text(
                            'تاريخ الالغاء',
                            style: AppFonts.style12light,
                          ),
                          search != null ? Container():    Text(
                            detailsUser != null ?
                            cancelDate.toString() :
                            cubit.getAllTaskList![index].cancelled_date.toString(),
                            style: AppFonts.style10lightGrey,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.h,),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      case 'completed' :
        return Container(
          margin:  EdgeInsets.symmetric(vertical: 8.h),
          padding: const EdgeInsets.all(AppDefaults.padding / 2),
          decoration: BoxDecoration(
            color: globalDark ? AppColors.cardColorDark : AppColors.cardColor,
            border: Border.all(color: globalDark ? AppColors.borderColorDark : AppColors.borderColor, width: 0.5),
            borderRadius: BorderRadius.circular(8.0.r),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 8.0.h,right: 8.w,top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          avatar != 'null' ?
                          Container(
                              margin: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
                              height: 30.h,
                              width: 30.w,
                              child: NetworkImageWithLoader(
                                  borderRadius: BorderRadius.circular(5.r),
                                  avatar.toString())
                          ) :
                          Padding(
                            padding: EdgeInsets.only(right: 2.0.w,left: 10.0.w),
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                color: AppColors.gray,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                          ),

                          Flexible(
                            child:
                            role == "3" ?
                            Text(
                              '${AppCubit.get(context).getInfoLogin!.first_name} ${AppCubit.get(context).getInfoLogin!.last_name}',
                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ) :
                            Text(
                              names,
                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'مكتمل',
                        style: AppFonts.style12bold.copyWith(color: AppColors.success),

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                           Icon(Icons.location_on_outlined,
                             color:globalDark ? AppColors.placeholder
                                 : AppColors.textBlack),
                          SizedBox(width: 4.h),
                          Flexible(
                            child: Text(
                              location,
                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),


                    SizedBox(width: 10.w,),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          search != null ? Container():    Text(
                            'تاريخ الاكتمال',
                            style: AppFonts.style12light,
                          ),
                          search != null ? Container():   Text(
                            detailsUser != null ?
                           completeDate.toString() :
                            cubit.getAllTaskList![index].complete_date.toString(),
                            style: AppFonts.style10lightGrey,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.h,),
                        ],
                      ),
                    ),
                  ],
                ),
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
                    Flexible(
                      child: Row(
                        children: [
                          avatar != 'null' ? Container(
                              margin: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),

                              ),
                              height: 30.h,
                              width: 30.w,
                              child: NetworkImageWithLoader(
                                avatar?.toString() ?? '',
                                borderRadius: BorderRadius.circular(5.r),
                              )
                          ) :   Padding(
                            padding:  EdgeInsets.only(right: 2.0.w,left: 10.0.w),
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                color: AppColors.gray,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                          ),

                          Flexible(
                            child:
                            role == "3" ? Text('${AppCubit.get(context).getInfoLogin!.first_name} ${AppCubit.get(context).getInfoLogin!.last_name}',
                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ) :
                            Text(
                              names,

                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),


                    Container(

                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: AppColors.inbox,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        statusText,
                        style: AppFonts.style12light,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                           Icon(Icons.location_on_outlined
                             ,color:globalDark ? AppColors.placeholder
                                   : AppColors.textBlack),
                          SizedBox(width: 4.h),
                          Flexible(
                            child: Text(
                              location,
                              style: AppFonts.style12light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),


                    SizedBox(width: 10.w,),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          search != null ? Container():    Text(
                            'تاريخ الانشاء',
                            style: AppFonts.style12light,
                          ),
                          search != null ? Container():    Text(
                           detailsUser != null?
                           createDate.toString() :
                            cubit.getAllTaskList![index].created_on.toString(),
                            style: AppFonts.style10lightGrey,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.h,),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );

    }

  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/network_image.dart';
import 'package:itsale/features/auth/data/cubit.dart';

import '../../../core/app/app.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/utils/token.dart';
import '../data/cubit/cubit.dart';

class TaskCardGrid extends StatelessWidget {
  final Color statusColor;
  final String statusText;
  final String taskName;
  final String taskNotes;
  final int  index;
 final  bool?  search  ;
 final  bool?    detailsUser  ;
  final String? completeDate;
  final  String? progressDate;
  final String? createDate;
  final String? cancelDate;
  final String location;
  final String names;
  final String avatar;

  const TaskCardGrid({super.key,
    required this.statusColor,
    required this.statusText,
    this.search,
    required this.taskName,
    required this.taskNotes,
    required this.index,

    required this.location,
    required this.names,
    required this.avatar, this.completeDate, this.progressDate, this.createDate, this.cancelDate, this.detailsUser,
  });

  @override
  Widget build(BuildContext context) {
    var cubit =  TasksCubit.get(context);

    switch(statusText)
    {
      case 'inbox' :
        return Container(

          margin:  EdgeInsets.symmetric(vertical: 8.h),

          decoration: BoxDecoration(
            border: Border.all(
                color: globalDark ? AppColors.cardColorDark  : AppColors.placeholder
            ),
            borderRadius: BorderRadius.circular(5.r),

          ),
          child: Padding(
            padding:  EdgeInsets.only(left: 8.0.h,right: 8.w,top: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          avatar != 'null' ? Container(
                              height: 30.h,
                              width: 30.w,
                              margin: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),

                              ),
                              child: NetworkImageWithLoader(avatar.toString(),                              borderRadius: BorderRadius.circular(5.r),
                              )) :   Padding(
                            padding:  EdgeInsets.only(right: 2.0.w,left: 8.0.w),
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: const  BoxDecoration(
                                color: AppColors.gray,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ),

                          Flexible(
                            child:
                            role == "3" ? Text('${AppCubit.get(context).getInfo!.first_name.toString()} ${AppCubit.get(context).getInfo!.last_name.toString()}' ,
                              style: AppFonts.style10light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ) :
                            Text(names,
                              style: AppFonts.style10light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // const  Spacer(),
                    // // const Icon(Icons.more_vert),

                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  taskName,
                  style: AppFonts.style12bold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
                SizedBox(height: 8.h),
                Text(
                  taskNotes,
                  style: AppFonts.style12light,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
                SizedBox(height: 8.h),

                Row(
                  children: [
                     Icon(Icons.location_on_outlined,color:
                     globalDark ? AppColors.placeholder
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
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'قيد الإنتظار',
                    style: AppFonts.style12bold.copyWith(color: AppColors.warning),

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                  ),
                ),

                SizedBox(height: 10.w,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        search != null ? Container() :  Text(
                          'تاريخ الانشاء',
                          style: AppFonts.style10light,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,

                        ),
                        search != null ? Container() :  Text(
                          detailsUser != null ?
                          createDate.toString() :
                          cubit.getAllTaskList![index].created_on.toString(),
                          style: AppFonts.style10light,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,

                        ),

                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      case 'progress' :
        return Container(

          margin:  EdgeInsets.symmetric(vertical: 8.h),

          decoration: BoxDecoration(
            border: Border.all(
                color: globalDark ? AppColors.cardColorDark  : AppColors.placeholder

            ),
            borderRadius: BorderRadius.circular(5.r),

          ),
          child: Padding(
            padding:  EdgeInsets.only(left: 8.0.h,right: 8.w,top: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          avatar != 'null' ? Container(
                              height: 30.h,
                              width: 30.w,
                              margin: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),

                              ),
                              child: NetworkImageWithLoader(avatar.toString(),                              borderRadius: BorderRadius.circular(5.r),
                              )) :   Padding(
                            padding:  EdgeInsets.only(right: 2.0.w,left: 8.0.w),
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: const  BoxDecoration(
                                color: AppColors.gray,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ),

                          Flexible(
                            child:
                            role == "3" ? Text('${AppCubit.get(context).getInfo!.first_name.toString()} ${AppCubit.get(context).getInfo!.last_name.toString()}' ,
                              style: AppFonts.style10light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ) :
                            Text(names,
                              style: AppFonts.style10light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // const  Spacer(),
                    // const Icon(Icons.more_vert),

                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  taskName,
                  style: AppFonts.style12bold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
                SizedBox(height: 8.h),
                Text(
                  taskNotes,
                  style: AppFonts.style12light,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
                SizedBox(height: 8.h),

                Row(
                  children: [
                     Icon(Icons.location_on_outlined,color: globalDark ? AppColors.placeholder
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
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: AppColors.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'تم الإستلام',
                    style: AppFonts.style12bold.copyWith(color: AppColors.info),

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                  ),
                ),

                SizedBox(height: 10.w,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        search != null ? Container() :   Text(
                          'تاريخ الاستلام',
                          style: AppFonts.style10light,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,

                        ),
                     search != null ? Container():   Text(
                       detailsUser != null ?
                          progressDate.toString() :
                          cubit.getAllTaskList![index].modified_on.toString(),
                          style: AppFonts.style10lightGrey,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,

                        ),

                      ],
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

          decoration: BoxDecoration(
            border: Border.all(
                color: globalDark ? AppColors.cardColorDark  : AppColors.placeholder
            ),
            borderRadius: BorderRadius.circular(5.r),

          ),
          child: Padding(
            padding:  EdgeInsets.only(left: 8.0.h,right: 8.w,top: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          avatar != 'null' ? Container(
                              height: 30.h,
                              width: 30.w,
                              margin: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),

                              ),
                              child: NetworkImageWithLoader(avatar.toString(),                              borderRadius: BorderRadius.circular(5.r),
                              )) :   Padding(
                            padding:  EdgeInsets.only(right: 2.0.w,left: 8.0.w),
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: const  BoxDecoration(
                                color: AppColors.gray,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ),

                          Flexible(
                            child:
                            role == "3" ? Text('${AppCubit.get(context).getInfo!.first_name.toString()} ${AppCubit.get(context).getInfo!.last_name.toString()}' ,
                              style: AppFonts.style10light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ) :
                            Text(names,
                              style: AppFonts.style10light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // const  Spacer(),
                    // const Icon(Icons.more_vert),

                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  taskName,
                  style: AppFonts.style12bold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
                SizedBox(height: 8.h),
                Text(
                  taskNotes,
                  style: AppFonts.style12light,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
                SizedBox(height: 8.h),

                Row(
                  children: [
                     Icon(Icons.location_on_outlined,color: globalDark ? AppColors.placeholder
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
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'ملغي',
                    style: AppFonts.style12bold.copyWith(color: AppColors.danger),

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                  ),
                ),

                SizedBox(height: 10.w,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        search != null ? Container():   Text(
                          'تاريخ الالغاء',
                          style: AppFonts.style10light,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,

                        ),
                    search != null ? Container() :   Text(
                      detailsUser != null ?
                          cancelDate.toString() :
                          cubit.getAllTaskList![index].cancelled_date.toString(),
                          style: AppFonts.style10lightGrey,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,

                        ),

                      ],
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

          decoration: BoxDecoration(
            border: Border.all(
                color: globalDark ? AppColors.cardColorDark  : AppColors.placeholder
            ),
            borderRadius: BorderRadius.circular(5.r),

          ),
          child: Padding(
            padding:  EdgeInsets.only(left: 8.0.h,right: 8.w,top: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          avatar != 'null' ? Container(
                              height: 30.h,
                              width: 30.w,
                              margin: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),

                              ),
                              child: NetworkImageWithLoader(avatar.toString(),                              borderRadius: BorderRadius.circular(5.r),
                              )) :   Padding(
                            padding:  EdgeInsets.only(right: 2.0.w,left: 8.0.w),
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: const  BoxDecoration(
                                color: AppColors.gray,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ),

                          Flexible(
                            child:
                            role == "3" ? Text('${AppCubit.get(context).getInfo!.first_name.toString()} ${AppCubit.get(context).getInfo!.last_name.toString()}' ,
                              style: AppFonts.style10light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ) :
                            Text(names,
                              style: AppFonts.style10light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // const  Spacer(),
                    // const Icon(Icons.more_vert),

                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  taskName,
                  style: AppFonts.style12bold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
                SizedBox(height: 8.h),
                Text(
                  taskNotes,
                  style: AppFonts.style12light,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
                SizedBox(height: 8.h),

                Row(
                  children: [
                     Icon(Icons.location_on_outlined,color:
                     globalDark ? AppColors.placeholder
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
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'مكتمل',
                    style: AppFonts.style12bold.copyWith(color: AppColors.success),

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                  ),
                ),

                SizedBox(height: 10.w,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        search != null ? Container( ): Text(
                          'تاريخ الاكتمال',
                          style: AppFonts.style10light,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,

                        ),
                        search != null ? Container() :     Text(
                          detailsUser != null ?
                          completeDate.toString() :
                          cubit.getAllTaskList![index].complete_date.toString(),
                          style: AppFonts.style10lightGrey,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,

                        ),

                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      // case 'hold' :
      //   return Container(
      //
      //     margin:  EdgeInsets.symmetric(vertical: 8.h),
      //
      //     decoration: BoxDecoration(
      //       border: Border.all(color: AppColors.placeholder),
      //       borderRadius: BorderRadius.circular(5.r),
      //
      //     ),
      //     child: Padding(
      //       padding:  EdgeInsets.only(left: 8.0.h,right: 8.w,top: 16.h),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               Expanded(
      //                 child: Row(
      //                   children: [
      //                     avatar != 'null' ? Container(
      //                         height: 30.h,
      //                         width: 30.w,
      //                         margin: EdgeInsets.only(left: 10.w),
      //                         decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(5.r),
      //
      //                         ),
      //                         child: NetworkImageWithLoader(avatar.toString(),                              borderRadius: BorderRadius.circular(5.r),
      //                         )) :   Padding(
      //                       padding:  EdgeInsets.only(right: 2.0.w,left: 8.0.w),
      //                       child: Container(
      //                         height: 30.h,
      //                         width: 30.w,
      //                         decoration: const  BoxDecoration(
      //                           color: AppColors.gray,
      //                           shape: BoxShape.rectangle,
      //                         ),
      //                       ),
      //                     ),
      //
      //                     Flexible(
      //                       child:
      //                       role == "3" ? Text('${AppCubit.get(context).getInfo!.first_name.toString()} ${AppCubit.get(context).getInfo!.last_name.toString()}' ,
      //                         style: AppFonts.style10light,
      //                         maxLines: 2,
      //                         overflow: TextOverflow.ellipsis,
      //                       ) :
      //                       Text(names,
      //                         style: AppFonts.style10light,
      //                         maxLines: 2,
      //                         overflow: TextOverflow.ellipsis,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //
      //               // const  Spacer(),
      // //               const Icon(Icons.more_vert),
      //
      //             ],
      //           ),
      //           SizedBox(height: 8.h),
      //           Text(
      //             taskName,
      //             style: AppFonts.style12bold,
      //             maxLines: 2,
      //             overflow: TextOverflow.ellipsis,
      //
      //           ),
      //           SizedBox(height: 8.h),
      //           Text(
      //             taskNotes,
      //             style: AppFonts.style12light,
      //             maxLines: 2,
      //             overflow: TextOverflow.ellipsis,
      //
      //           ),
      //           SizedBox(height: 8.h),
      //
      //           Row(
      //             children: [
      //               const Icon(Icons.location_on_outlined,color: AppColors.textBlack,),
      //               SizedBox(width: 4.h),
      //               Flexible(
      //                 child: Text(
      //                   location,
      //                   style: AppFonts.style12light,
      //                   maxLines: 2,
      //                   overflow: TextOverflow.ellipsis,
      //
      //                 ),
      //               ),
      //             ],
      //           ),
      //           SizedBox(height: 8.h),
      //           Container(
      //             padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      //             decoration: BoxDecoration(
      //               color: statusColor,
      //               borderRadius: BorderRadius.circular(2),
      //             ),
      //             child: Text(
      //               statusText,
      //               style: AppFonts.style12lightWhite,
      //               maxLines: 2,
      //               overflow: TextOverflow.ellipsis,
      //
      //             ),
      //           ),
      //
      //           SizedBox(height: 10.w,),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //
      //             children: [
      //               Column(
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 crossAxisAlignment: CrossAxisAlignment.end,
      //                 children: [
      //
      //                   Text(
      //                     'تاريخ الالغاء',
      //                     style: AppFonts.style10light,
      //                     maxLines: 2,
      //                     overflow: TextOverflow.ellipsis,
      //
      //                   ),
      //                   Text(
      //                     role == "3" ?
      //                     cubit.getUserTaskList![index].cancelled_date.toString() :
      //                     cubit.getAllTaskList![index].cancelled_date.toString(),
      //                     style: AppFonts.style10lightGrey,
      //                     maxLines: 2,
      //                     textAlign: TextAlign.center,
      //                     overflow: TextOverflow.ellipsis,
      //
      //                   ),
      //
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   );

      default :
        return Container(

          margin:  EdgeInsets.symmetric(vertical: 8.h),

          decoration: BoxDecoration(
            border: Border.all(
                color: globalDark ? AppColors.cardColorDark  : AppColors.placeholder
            ),
            borderRadius: BorderRadius.circular(5.r),

          ),
          child: Padding(
            padding:  EdgeInsets.only(left: 8.0.h,right: 8.w,top: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          avatar != 'null' ? Container(
                              height: 30.h,
                              width: 30.w,
                              margin: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),

                              ),
                              child: NetworkImageWithLoader(avatar.toString(),                              borderRadius: BorderRadius.circular(5.r),
                              )) :   Padding(
                            padding:  EdgeInsets.only(right: 2.0.w,left: 8.0.w),
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: const  BoxDecoration(
                                color: AppColors.gray,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ),

                          Flexible(
                            child:
                            role == "3" ? Text('${AppCubit.get(context).getInfo!.first_name.toString()} ${AppCubit.get(context).getInfo!.last_name.toString()}' ,
                              style: AppFonts.style10light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ) :
                            Text(names,
                              style: AppFonts.style10light,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // const  Spacer(),
                    // const Icon(Icons.more_vert),

                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  taskName,
                  style: AppFonts.style12bold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
                SizedBox(height: 8.h),
                Text(
                  taskNotes,
                  style: AppFonts.style12light,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                ),
                SizedBox(height: 8.h),

                Row(
                  children: [
                     Icon(Icons.location_on_outlined,color:
                     globalDark ? AppColors.placeholder
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
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    statusText,
                    style: AppFonts.style12light,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                  ),
                ),

                SizedBox(height: 10.w,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        search != null ? Container() :    Text(
                          'تاريخ الانشاء',
                          style: AppFonts.style10light,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,

                        ),
                        search != null ? Container() :    Text(
                          detailsUser != null ?
                         createDate.toString() :
                          cubit.getAllTaskList![index].created_on.toString(),
                          style: AppFonts.style10lightGrey,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,

                        ),

                      ],
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
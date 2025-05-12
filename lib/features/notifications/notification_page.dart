import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/states.dart';

import '../../core/app/app.dart';
import '../../core/components/default_app_bar.dart';
import '../../core/constants/app_animation.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/constants/navigation.dart';
import '../../core/utils/token.dart';
import '../../core/utils/transition.dart';
import '../Tasks_Screens/screens/tasks.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    TasksCubit.get(context).getNotificationForOneUserFun();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit  = TasksCubit.get(context);
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocConsumer<TasksCubit,TasksStates>(
            listener: (context, state) {
        
            },
            builder: (context, state) {
              if(state is GetLoadingAllNotificationState)
              {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: AppLottie.loader),
                  ],
                );
              }
        
            return  Column(
              children: [
                SizedBox(height: 10.h),
                 Padding(
                   padding:  EdgeInsets.symmetric(horizontal:  20.0.w),
                   child: const CustomAppBar(title: 'الاشعارات', back: true,),
                 ),
                SizedBox(height: 10.h),

                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
        reverse: true,
                    itemCount: cubit.getNotificationsList!.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 0.h),
                    itemBuilder: (context, index) {
                      return
                        InkWell(
                          onTap: ()
                          {
                          },
                          child: NotificationTile(

                            imageLink: 'https://i.imgur.com/e3z9DmE.png',
                            title: cubit.getNotificationsList![index].title.toString(),
                            subtitle: cubit.getNotificationsList![index].message.toString(),
                            time: cubit.getNotificationsList![index].created_on.toString(),
                          ),
                        );
        
                    },
                  ),
              ],
            );
            },
        
          ),
        ),
      ),



    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    this.imageLink,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  final String? imageLink;
  final String title;
  final String subtitle;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding,vertical: AppDefaults.padding / 2),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.placeholder,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Expanded(
              flex: 3,
              child: ListTile(

                title: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: globalDark
                            ? AppColors.textWhite :  AppColors.textBlack,
                      ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 4),
                    Text(subtitle),
                    const SizedBox(height: 4),
                    Text(
                      time.substring(12,16),
                      style: AppFonts.style12colored,
                    ),
                  ],
                ),

              ),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding:  EdgeInsets.only(top: 10.h),
                child: Text(
                  time.substring(0,10),
                  style: AppFonts.style14normal,


                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

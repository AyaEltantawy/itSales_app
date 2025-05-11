import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:itsale/core/constants/app_animation.dart';
import 'package:itsale/core/constants/app_images.dart';
import 'package:lottie/lottie.dart';

import '../../features/Tasks_Screens/data/cubit/cubit.dart';
import '../../features/auth/data/cubit.dart';
import '../../features/home/data/cubit.dart';
import '../../generated/l10n.dart';
import 'app_colors.dart';
import 'app_defaults.dart';



class NoInternet extends StatefulWidget

{
  const NoInternet({super.key});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {



  @override
  Widget build(BuildContext context) {
    return  Column(

        children: [
          SizedBox(height: 50.h,),
          Image.asset(AppImages.noInternet),

          Text(S.of(context).no_internet_connection,style: GoogleFonts.cairo(fontSize: 20.sp,fontWeight: FontWeight.bold)),
          SizedBox(height: 20.h,),

          InkWell(
              onTap: () async  {

                if(await InternetConnectionChecker().hasConnection == true)
                {

                  AppCubit.get(context).getUserDataFun(context);
                  print('hello');
                  TasksCubit.get(context).getAllTasksFun();
                  EmployeeCubit.get(context).getAllSales();
                  EmployeeCubit.get(context).getAdmins(role: 1);
                  EmployeeCubit.get(context).getAdmins(role: 3);
                  EmployeeCubit.get(context).getAllEmployee();
                }


              },
              child: Container(

                height: 48.h,
                width: 245.w,
                padding: EdgeInsets.symmetric(horizontal:  26.w,vertical: 0.0),
                decoration: BoxDecoration(
                  borderRadius: AppDefaults.borderRadius,
                  color: AppColors.primary,

                ),
                child: Row(
                  children: [
                     Icon(Icons.refresh, color: AppColors.textWhite, size: 32,),
                    SizedBox(width: 10.w,),
                    Text(S.of(context).try_again,style: GoogleFonts.cairo(fontSize: 18.sp,fontWeight: FontWeight.bold, color: AppColors.textWhite)),
                  ],
                ),
              )),


        ],

    );
  }
}




Widget loader() => Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    SizedBox(height: 200.h,),
    Center(
      child: Lottie.asset(AppLottie.loader,height: 230.h,width: 230.w),),
  ],
);
Widget loaderAddition() => Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [

    Center(
      child: Lottie.asset(AppLottie.loader,height: 230.h,width: 230.w),),
  ],
);

Future navigateFinish(
    BuildContext context,
    String name,
    ) =>
    Navigator.of(context).pushNamedAndRemoveUntil(name,
          (route) => false,
      // SliderRight(page: widget),

    );

Future navigateTo(
    BuildContext context,
    String name,
    ) =>

    Navigator.pushNamed( context,

      name,


    );


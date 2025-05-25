import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app/app.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../auth/data/cubit.dart';
import '../../../auth/data/states.dart';
import 'color_of_the_app_cubit.dart';
import 'color_of_the_app_state.dart';

class Color_of_the_appPage extends StatefulWidget {
  @override
  State<Color_of_the_appPage> createState() => _Color_of_the_appPageState();
}

class _Color_of_the_appPageState extends State<Color_of_the_appPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => Color_of_the_appCubit(),
        child: BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
          return Scaffold(
              body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10.w),
                  Icon(Icons.dark_mode_outlined,
                      color: globalDark
                          ? AppColors.textWhite
                          : AppColors.textBlack),
                  SizedBox(width: 10.w),
                  Text(AppLocalizations.of(context)!.translate("dark_mode"),
                      style: AppFonts.style16semiBold),
                  const Spacer(),
                  Switch(
                    value: AppCubit.get(context).isDarkMode,
                    onChanged: (value) {
                      context.read<AppCubit>().toggleTheme();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ));
        }));
  }
}

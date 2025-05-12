import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/constants/navigation.dart';
import '../../../core/routes/app_routes.dart';
import '../../home/components/widgets_for_tasks_screen.dart';

class SelectAnyButtonBottomSheet extends StatelessWidget {
  const SelectAnyButtonBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {
                navigateTo(context, AppRoutes.addEmployee);
              },
              child: addEmployee(
                  'موظف', AppFonts.style12light, AppColors.placeholder)),
          SizedBox(
            width: 10.w,
          ),
          InkWell(
              onTap: () {
                navigateTo(context, AppRoutes.addTask);
              },
              child: addEmployee(
                  'مهمة', AppFonts.style12light, AppColors.placeholder)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app/app.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/token.dart';
import 'bottom_app_bar_item.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onNavTap,
  });

  final int currentIndex;
  final void Function(int) onNavTap;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {

    return BottomAppBar(


     shape: const CircularNotchedRectangle(),
      notchMargin: AppDefaults.margin ,
      color: globalDark ? AppColors.cardColorDark :
      AppColors.cardColor,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w, ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomAppBarItem(
              name: '',
             icon:AppIcons.menu_outlined ,
              isActive: widget.currentIndex == 4,
              onTap: () => widget.onNavTap(4),
            ),
            BottomAppBarItem(
              name: '',
              icon: AppIcons.person_2_outlined, isActive: widget.currentIndex == 3,



              onTap: () => widget.onNavTap(3),
            ),

            const Padding(
              padding: EdgeInsets.all(AppDefaults.padding * 1.5),
              child: SizedBox(width: AppDefaults.margin),
            ),

            BottomAppBarItem(
              name: '',
              icon: AppIcons.task_outlined,
              isActive: widget.currentIndex == 1,
              onTap: () => widget.onNavTap(1),
            ),

            BottomAppBarItem(
              name: '',
              icon: AppIcons.home_outlined,
              isActive: widget.currentIndex == 0,
              onTap: () => widget.onNavTap(0),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/components/network_image.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/utils/transition.dart';
import '../../addEmployee/screens/add_employee.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String role;
  final String avatar;
  final int id;
  const ProfileHeader({super.key, required this.name,required this.avatar,required this.role, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Adds padding around the header
      child: Row(
        children: [
        avatar == 'لا يوجد' ?   Container(
            height: 40.h, // Avatar height
            width: 40.h, // Avatar width
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(8.r), // Rounded corners for avatar
            ),
          ) : Container(
          height: 42.h,
          width: 42.w,
          decoration: BoxDecoration(
            //  color: AppColors.lightGreenColor,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: NetworkImageWithLoader(avatar),
        ),
          SizedBox(width: 16.w), // Adds space between avatar and text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppFonts.style20Bold), // Employee name
              Text(role, style: AppFonts.style12light), // Employee role
            ],
          ),
          const Spacer(), // Pushes buttons to the right
          Container(
            decoration: BoxDecoration(
              color:  AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r), // Rounded corners for button
            ),
            child: IconButton(
              icon: const Icon(Icons.edit, color: AppColors.greenColor), // Edit button
              onPressed: ()
              {
              Navigator.push(context,  animatedNavigation(screen:  AddNewEmployee(isEdit: true, empId: id,)));

              },
            ),
          ),
        ],
      ),
    );
  }
}

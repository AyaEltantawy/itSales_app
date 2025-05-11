import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_defaults.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/constants/app_icons.dart';
import 'package:svg_flutter/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/app/app.dart';
import '../../../core/constants/app_colors.dart';

class ContactOptionsCard extends StatelessWidget {
  final String phone1;
  final String phone2;
  final String empEmail;
  final String whatsapp;
  const ContactOptionsCard({super.key,
    required this.phone1,
    required this.phone2,
    required this.empEmail,
    required this.whatsapp,

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(AppDefaults.padding.w / 1.6 ),
      color:  globalDark ? AppColors.cardColorDark : AppColors.textWhite,
      shape: RoundedRectangleBorder(
        side:  BorderSide(width: 1, color:  globalDark ? AppColors.borderColorDark : AppColors.placeholder),
        borderRadius: BorderRadius.circular(8.r), // Rounded edges
      ),
      elevation: 0.0, // Shadow for the card
      child: Padding(
        padding: EdgeInsets.all(12.h), // Inner padding for the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تواصل مع الموظف',
              style: AppFonts.style16semiBold,
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(child: InkWell(
                    onTap: ()
                    {
                      phone1 != 'لا يوجد' ?  launchUrl(Uri(
                        scheme: 'tel',
                        path: phone1,
                      )) : Container();
                    },
                    child: _buildContactButton('تواصل',  phone1, Colors.blue, Colors.blueAccent,Icons.local_phone_outlined))),
                SizedBox(width: 12.w), // Horizontal space between buttons
                Expanded(child: InkWell(
    onTap: ()
    {
      whatsapp != 'لا يوجد'  ? launchUrl(Uri(
    scheme: 'tel',
    path: whatsapp,
    ))  :Container();
    },

                  child: _buildContactButton('واتساب', whatsapp,
                    Colors.green, Colors.green,  null ,
                    SvgPicture.asset(AppIcons.whatsAap,height: 22.h,),),
                )),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(child: InkWell(
                    onTap: ()
                    {
                      phone2 != 'لا يوجد' ? launchUrl(Uri(
                        scheme: 'tel',
                        path: phone2,
                      )) : Container();
                    },
                    child: _buildContactButton('هاتف بديل',  phone2, Colors.blue, Colors.blueAccent,Icons.local_phone_outlined,))),
                SizedBox(width: 12.w), // Horizontal space between buttons

                Expanded(child: InkWell(
                    onTap: ()
                    {
                      empEmail != 'لا يوجد' ?  launchUrl(Uri(
                        scheme: 'mailto',
                        path: empEmail,
                      )) : Container();
                    },
                    child: _buildContactButton('بريد إلكتروني', empEmail, Colors.orange, Colors.orangeAccent,  Icons.email,))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton(String label, String contactInfo, Color borderColor, Color iconColor , [IconData? icon , Widget? widget]) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w), // Padding inside the button
      
      decoration: BoxDecoration(
           
        border: Border.all(color: borderColor, width: 1.5), // Border color and thickness
        borderRadius: BorderRadius.circular(8.r), // Rounded edges
      ),
      child: Row(
        children: [


          Flexible(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: borderColor,
                  ),
                ),
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  contactInfo,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color:   globalDark ?
                    AppColors.textWhite : AppColors.textBlack ,
                  ),
                ),
              ],
            ),
          ),
        const Spacer(),
        widget ??   Icon(icon, color: iconColor),
        ],
      ),
    );
  }
}

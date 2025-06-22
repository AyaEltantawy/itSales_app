import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/app/app.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/localization/app_localizations.dart';
import 'package:itsale/features/Tasks_Screens/data/models/get_task_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/l10n.dart';
import '../data/download_image.dart';
import '../screens/end_task/web_view.dart';

class TaskDetailsSection extends StatelessWidget {
  final String nameEmployee;

  final String nameTask;

  final String description;

  final String deadline;

  const TaskDetailsSection(
      {super.key,
      required this.nameEmployee,
      required this.nameTask,
      required this.description,
      required this.deadline});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDefaults.padding / 1.4),
      decoration: BoxDecoration(
        color: globalDark ? AppColors.cardColorDark : AppColors.cardColor,
        border: Border.all(
            color:
                globalDark ? AppColors.borderColorDark : AppColors.borderColor,
            width: 0.5),
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.translate("main_data"),
            style: AppFonts.style16semiBold,
          ),
          SizedBox(height: 20.h),
          _buildRow(label: 'الموظف المكلّف', value: nameEmployee),
          Divider(
              color: globalDark
                  ? AppColors.borderColorDark
                  : AppColors.borderColor),
          SizedBox(height: 12.h),
          _buildRow(label: 'مهلة المهمة', value: deadline),
          Divider(
              color: globalDark
                  ? AppColors.borderColorDark
                  : AppColors.borderColor),
          SizedBox(height: 12.h),
          _buildRow(label: 'اسم المهمة', value: nameTask),
          Divider(
              color: globalDark
                  ? AppColors.borderColorDark
                  : AppColors.borderColor),
          SizedBox(height: 12.h),
          _buildDescription(label: 'وصف المهمة', value: description),
        ],
      ),
    );
  }

  Widget _buildRow({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.style14normal,
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            value,
            style: AppFonts.style16semiBold,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.style14normal,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          decoration: BoxDecoration(
            // color:globalDark ?  AppColors.textBlack :  AppColors.cardColor,

            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            value,
            style: AppFonts.style16semiBold,
          ),
        ),
      ],
    );
  }
}

class LocationSection extends StatelessWidget {
  final String address;
  final String link;

  const LocationSection({super.key, required this.address, required this.link});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color:
                globalDark ? AppColors.borderColorDark : AppColors.borderColor,
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'الموقع الجغرافي',
            style: AppFonts.style16semiBold,
          ),
          SizedBox(height: 16.h),
          _buildRow(label: 'عنوان المهمة الحالي', value: address),
          SizedBox(height: 8.h),
          Divider(
              color: globalDark
                  ? AppColors.borderColorDark
                  : AppColors.borderColor),
          SizedBox(height: 8.h),
          InkWell(
              onTap: () async {
                if (link == null || link!.isEmpty || link == AppLocalizations.of(context)!.translate("not_available")) {
                  print('Invalid or empty link, cannot open.');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('الرابط غير متوفر')),
                  );
                  return;
                }

                final Uri url = Uri.parse(link!);

                if (await canLaunchUrl(url)) {
                  final bool success = await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                  if (!success) {
                    print('Failed to launch URL externally');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تعذر فتح الرابط')),
                    );
                  }
                } else {
                  print('Cannot launch URL: $link');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تعذر فتح الرابط')),
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildRow(
                        label: 'رابط الموقع', value: link ?? AppLocalizations.of(context)!.translate("not_available")),
                  ),
                  Container(
                    height: 40.h,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: globalDark ? Colors.grey[800] : Colors.white,
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Text(
                      "اذهب للموقع",
                      style: TextStyle(
                        color: globalDark ? Colors.white : Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ))
        ]));
  }

  Widget _buildRow({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 4.h),
        Text(value, style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }
}

Widget _buildRow({required String label, required String value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: AppFonts.style14normal,
      ),
      SizedBox(height: 4.h),
      Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: globalDark ? AppColors.textBlack : AppColors.cardColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          value,
          style: AppFonts.style16semiBold,
        ),
      ),
    ],
  );
}

class ClientSection extends StatelessWidget {
  final String nameClient;
  final String phoneClient;
  final String notes;

  const ClientSection(
      {super.key,
      required this.nameClient,
      required this.phoneClient,
      required this.notes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: globalDark ? AppColors.borderColorDark : AppColors.borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'بيانات العميل',
            style: AppFonts.style16semiBold,
          ),
          SizedBox(height: 16.h),
          _buildRow(label: 'اسم العميل', value: nameClient),
          SizedBox(height: 8.h),
          Divider(
              color: globalDark
                  ? AppColors.borderColorDark
                  : AppColors.borderColor),
          SizedBox(height: 8.h),
          _buildRow(label: 'رقم هاتف العميل', value: phoneClient),
          SizedBox(height: 8.h),
          Divider(
              color: globalDark
                  ? AppColors.borderColorDark
                  : AppColors.borderColor),
          SizedBox(height: 8.h),
          _buildDescription(label: 'الملاحظات', value: notes),
        ],
      ),
    );
  }

  Widget _buildRow({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.style14normal,
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: globalDark ? AppColors.textBlack : AppColors.cardColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            value,
            style: AppFonts.style16semiBold,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.style14normal,
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: globalDark ? AppColors.textBlack : AppColors.cardColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            value,
            style: AppFonts.style16semiBold,
          ),
        ),
      ],
    );
  }
}

class AttachmentsSection extends StatelessWidget {
  const AttachmentsSection({super.key, required this.files});

  final List<dynamic>? files;

  @override
  Widget build(BuildContext context) {
    if (files == null || files!.isEmpty) {
      return const SizedBox(); // لا توجد ملفات
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الملفات',
          style: AppFonts.style16semiBold,
        ),
        SizedBox(height: 16.h),
        ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10.h),
          itemCount: files!.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final fileItem = files![index];

            // حاول استخراج البيانات بشكل آمن
            final fileData = fileItem is Map<String, dynamic>
                ? fileItem['directus_files_id']
                : null;

            final fullUrl = (fileData is Map<String, dynamic> && fileData['location_data'] is Map)
                ? fileData['location_data']['full_url']?.toString() ?? ''
                : '';


            final fileName = fileData is Map<String, dynamic>
                ? fileData['title']?.toString() ?? 'ملف بدون اسم'
                : 'ملف غير معروف';

            final uploadedOn = fileData is Map<String, dynamic>
                ? fileData['uploaded_on']?.toString() ?? 'تاريخ غير معروف'
                : 'تاريخ غير معروف';

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoViewApp(fullUrl),
                  ),
                );
              },
              child: _buildAttachmentItem(
                fullUrl: fullUrl,
                fileName,
                uploadedOn,
                Icons.file_present,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAttachmentItem(String fileName, String date, IconData icon,
      {required String fullUrl}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: globalDark ? AppColors.textBlack : AppColors.cardColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: globalDark ? AppColors.borderColorDark : AppColors.borderColor,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              fileName,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(date, style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
          SizedBox(width: 10.w),
          IconButton(
            icon: Container(
              height: 36.h,
              width: 36.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: const Icon(Icons.file_download_outlined, color: Colors.black),
            ),
            onPressed: () {
              if (fullUrl.isNotEmpty) {
                downloadImage(fullUrl, fileName);
              }
            },
          ),
        ],
      ),
    );
  }
}






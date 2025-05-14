import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/app_buttons.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/themes/colors.dart';
import 'package:itsale/core/utils/token.dart';
import 'package:itsale/features/addEmployee/components/report_chart.dart';
import 'package:itsale/features/profile/widgets/reports/widgets/text_and_number.dart';
import 'package:itsale/features/profile/widgets/reports/widgets/text_and_radio_and_three_dots.dart';
import 'package:svg_flutter/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/constants/app_fonts.dart';
import '../../../../core/themes/styles.dart';
import 'reports_cubit.dart';
import 'reports_state.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ReportsCubit(),
        child: Scaffold(
            body: SafeArea(child: BlocBuilder<ReportsCubit, ReportsState>(
          builder: (context, state) {
            final controller = BlocProvider.of<ReportsCubit>(context);
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              children: [
                // role == 1 ?
                //  Container()
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              navigateTo(context, AppRoutes.profilePage);
                            },
                            child: Image.asset(
                              "assets/images/back_arrow_with_container.png",
                              width: 30.w,
                              height: 30.w,
                            )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'التقارير',
                          style: AppFonts.style16semiBold,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        controller.showFilterDialog(context);
                      },
                      child: Container(
                        width: 30.w,
                        height: 30.w,
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.filterIcon,
                          colorFilter: ColorFilter.mode(
                              AppColors.textWhite, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),

                Text(
                  "ملخص الأداء العام",
                  style: TextStyles.font20Weight500BaseBlack,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextAndNumber(
                  text: " مجموع المهمات المكتملة",
                  numberText: "244",
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextAndNumber(
                  text: " عدد المهام المفتوحة",
                  numberText: "17",
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextAndNumber(
                  text: " متوسط وقت أنجاز المهام",
                  numberText: "8h",
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextAndNumber(
                  text: "اجمالى عدد الموظفين",
                  numberText: "23",
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "تقارير المهام الأسبوعية",
                  style: TextStyles.font20Weight500BaseBlack,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.sp),
                      border: Border.all(
                        color: ColorsManager.mediumGrey,
                        width: 1,
                      )),
                  child: ReportChart(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "تصدير الملفات",
                  style: TextStyles.font20Weight500BaseBlack,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextAndRadioAndThreeDots(
                  text: "PNG",
                  value: "png",
                  selectedExportType: controller.selectedExportType,
                  toggleExportType: controller.toggleExportType,
                ),
                TextAndRadioAndThreeDots(
                  text: "Excel",
                  value: "excl",
                  selectedExportType: controller.selectedExportType,
                  toggleExportType: controller.toggleExportType,
                ),
                TextAndRadioAndThreeDots(
                  selectedExportType: controller.selectedExportType,
                  toggleExportType: controller.toggleExportType,
                  value: 'pdf',
                  text: "PDF",
                ),
                SizedBox(
                  height: 10.h,
                ),
                defaultButton(
                    context: context,
                    text: "Export Sevice Charts",
                    width: double.infinity,
                    height: 56.h,
                    isColor: true,
                    textSize: 15.sp,
                    toPage: (){})

              ],
            );
          },
        ))));
  }
}

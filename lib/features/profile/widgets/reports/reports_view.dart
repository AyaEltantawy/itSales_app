import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/features/addEmployee/components/report_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/constants/app_fonts.dart';
import 'reports_cubit.dart';
import 'reports_state.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ReportsCubit(),
        child: Scaffold(
            body: SafeArea(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
          children: [
            Text(
              'التقارير',
              style: AppFonts.style16semiBold,
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 20.h,),
            ReportChart(),

          ],
        ))));
  }
}

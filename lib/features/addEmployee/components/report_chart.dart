import 'package:flutter/material.dart';
import 'package:itsale/core/localization/app_localizations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../HomeEmployee/screens/home_employee.dart' show TaskSummarySection;
import '../../Tasks_Screens/data/cubit/cubit.dart';

class SalesData {
  final String date;
  final double value;

  SalesData(this.date, this.value);
}

class ReportChart extends StatelessWidget {
  const ReportChart({super.key});

  @override
  Widget build(BuildContext context) {
    final taskCubit = TasksCubit.get(context);
    final completedTasks = taskCubit.getAllTaskList!
        .where((task) => task.task_status == 'completed')
        .toList();
    final uncompletedTasks = taskCubit.getAllTaskList!
        .where((task) => task.task_status != 'completed')
        .toList();

    final int totalTasks = taskCubit.getAllTaskList!.length;

    final List<SalesData> service1Data = [
      SalesData(
        "مكتمل",
        completedTasks.length.toDouble(),
      ),
    ];
    final List<SalesData> service2Data = [
      SalesData(
        "غير مكتمل",
        uncompletedTasks.length.toDouble(),
      ),
    ];

    return Container(
      width: 300,
      height: 250,
      child: SfCartesianChart(
        title: ChartTitle(
          alignment: ChartAlignment.far,
          text: AppLocalizations.of(context)!.translate("weekly_statistics"),
        ),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: totalTasks.toDouble(),
          interval: 1,
        ),
        series: <CartesianSeries>[
          ColumnSeries<SalesData, String>(
            dataSource: service1Data,
            xValueMapper: (SalesData data, _) => data.date,
            yValueMapper: (SalesData data, _) => data.value,
            name: AppLocalizations.of(context)!.translate("service_1"),
            color: Colors.blue,
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
          ColumnSeries<SalesData, String>(
            dataSource: service2Data,
            xValueMapper: (SalesData data, _) => data.date,
            yValueMapper: (SalesData data, _) => data.value,
            name: AppLocalizations.of(context)!.translate("service_2"),
            color: Colors.blue[200],
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

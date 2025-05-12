import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../HomeEmployee/screens/home_employee.dart'
    show TaskSummarySection;
import '../../Tasks_Screens/data/cubit/cubit.dart';

class SalesData {
  final String date;
  final double value;

  SalesData(this.date, this.value);
}

class ReportChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskCubit = TasksCubit.get(context);
    final completedTasks = TasksCubit.get(context)
        .getAllTaskList!
        .where((task) => task.task_status == 'completed')
        .toList();
    final uncompletedTasks = TasksCubit.get(context)
        .getAllTaskList!
        .where((task) => task.task_status != 'completed')
        .toList();
    final List<SalesData> service1Data = [
      SalesData(
        '${completedTasks.length}/${TasksCubit.get(context).getAllTaskList!.length}',
        completedTasks.length.toDouble(),
      ),
    ];
    final List<SalesData> service2Data = [
      SalesData(
        '${uncompletedTasks.length}/${TasksCubit.get(context).getAllTaskList!.length}',
        completedTasks.length.toDouble(),
      ),
    ];
    return Container(
      width: 300,
      height: 250,
      child: SfCartesianChart(

        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: TasksCubit.get(context).getAllTaskList!.length.toDouble(),
            interval: 1),
        series: <CartesianSeries>[
          ColumnSeries<SalesData, String>(
            dataSource: service1Data,
            xValueMapper: (SalesData data, _) => data.date,
            yValueMapper: (SalesData data, _) => data.value,
            name: 'الخدمة 1',
            color: Colors.blue,
            dataLabelSettings: DataLabelSettings(isVisible: false),
          ),
          ColumnSeries<SalesData, String>(
            dataSource: service2Data,
            xValueMapper: (SalesData data, _) => data.date,
            yValueMapper: (SalesData data, _) => data.value,
            name: 'الخدمة 2',
            color: Colors.blue[200],
            dataLabelSettings: DataLabelSettings(isVisible: false),
          ),
        ],
      ),
    );
  }
}

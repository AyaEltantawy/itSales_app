import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../home/dialogs/product_filters_dialog.dart';
import 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsStateInit());

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialog();
      },
    );
  }

  String selectedExportType = 'bng';


  void toggleExportType(String exportType) {
    selectedExportType = exportType;
    emit(ToggleExportType());
  }
}
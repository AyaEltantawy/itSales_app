import 'package:bloc/bloc.dart';

import 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsState().init());


}

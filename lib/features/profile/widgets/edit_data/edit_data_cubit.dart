import 'package:bloc/bloc.dart';

import 'edit_data_state.dart';

class EditDataCubit extends Cubit<EditDataState> {
  EditDataCubit() : super(EditDataState().init());
}

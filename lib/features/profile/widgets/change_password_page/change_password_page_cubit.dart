import 'package:bloc/bloc.dart';

import 'change_password_page_state.dart';

class ChangePasswordPageCubit extends Cubit<ChangePasswordPageState> {
  ChangePasswordPageCubit() : super(ChangePasswordPageState().init());
}

import 'package:bloc/bloc.dart';

import 'password_changed_failed_state.dart';

class PasswordChangedFailedCubit extends Cubit<PasswordChangedFailedState> {
  PasswordChangedFailedCubit() : super(PasswordChangedFailedState().init());
}

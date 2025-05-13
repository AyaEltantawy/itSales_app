import 'package:bloc/bloc.dart';

import 'password_changed_success_state.dart';

class PasswordChangedSuccessCubit extends Cubit<PasswordChangedSuccessState> {
  PasswordChangedSuccessCubit() : super(PasswordChangedSuccessState().init());
}

import 'package:bloc/bloc.dart';

import 'success_state.dart';

class PasswordChangedSuccessCubit extends Cubit<PasswordChangedSuccessState> {
  PasswordChangedSuccessCubit() : super(PasswordChangedSuccessState().init());
}

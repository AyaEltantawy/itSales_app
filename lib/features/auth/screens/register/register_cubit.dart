import 'package:bloc/bloc.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterStateInit());
  bool isPasswordShown = false;
  onPassShowClicked() {

      isPasswordShown = !isPasswordShown;
      emit(PasswordShownState());

  }
}

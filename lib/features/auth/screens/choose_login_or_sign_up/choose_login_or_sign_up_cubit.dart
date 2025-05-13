import 'package:bloc/bloc.dart';

import 'choose_login_or_sign_up_state.dart';

class ChooseLoginOrSignUpCubit extends Cubit<ChooseLoginOrSignUpState> {
  ChooseLoginOrSignUpCubit() : super(ChooseLoginOrSignUpState().init());
}

import 'package:bloc/bloc.dart';

import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpState().init());
  String otpCode = "";
}

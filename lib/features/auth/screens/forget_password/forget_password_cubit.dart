import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordState().init());
  var emailController = TextEditingController();
}

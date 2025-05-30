import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/routes/magic_router.dart';
import '../../../../core/cache_helper/cache_helper.dart';

import '../../../../core/dio_helper.dart';

import '../../../../core/utils/snack_bar.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  void resetPassword({
    required BuildContext context,
    required String newPassword,
  }) async {
    String? resetToken = CacheHelper.getData(key: "reset_token");
    final body = {
      'token': resetToken,
      'password': newPassword,
    };

    emit(LoadingConfirm());

    try {
      final response = await DioHelper.post(
        "auth/password/reset",
        false,
        body: body,
      );

      final data = response.data;
      print("dataReset$data");
      if (data["public"] == true) {
        emit(LoadingSuccess());
        Utils.showSnackBar(context, "تم اعادة تعيين كلمة المرور بنجاح");

      } else {
        emit(LoadingError());
      }
    } catch (e) {
      emit(LoadingError());
    }
  }
}

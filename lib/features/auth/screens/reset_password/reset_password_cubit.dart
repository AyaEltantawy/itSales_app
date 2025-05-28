import 'package:bloc/bloc.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/routes/magic_router.dart';
import '../../../../core/dio_helper.dart';

import '../../../../core/utils/token.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  void resetPassword({

    required String newPassword,
  }) async {
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
      if (data['status'] == true) {
        emit(LoadingSuccess());
        navigateTo(MagicRouter.currentContext!, AppRoutes.login);
      } else {
        emit(LoadingError(message: data['message'] ?? "حدث خطأ غير معروف"));
      }
    } catch (e) {
      emit(LoadingError(message: "فشل الاتصال بالخادم"));
    }
  }
}

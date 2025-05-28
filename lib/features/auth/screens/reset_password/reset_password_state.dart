abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class LoadingConfirm extends ResetPasswordState {}

class LoadingSuccess extends ResetPasswordState {}

class LoadingError extends ResetPasswordState {
  final String message;
  LoadingError({this.message = "حدث خطأ غير معروف"});
}

abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class LoadingConfirm extends ResetPasswordState {}

class LoadingSuccess extends ResetPasswordState {}

class LoadingError extends ResetPasswordState {}

import '../../../addEmployee/data/models/add_employee_model.dart';
class RegisterState{}
class RegisterStateInit extends RegisterState {}
class RegisterLoadingState extends RegisterState {}
class PasswordShownState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final AddUserModel user;

  RegisterSuccessState(this.user);
}

class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState(this.message);
}

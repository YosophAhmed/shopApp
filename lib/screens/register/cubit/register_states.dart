import 'package:shop_app/models/login_model.dart';

abstract class RegisterStates {}

class InitialRegisterState extends RegisterStates {}

class LoadingRegisterState extends RegisterStates {}

class SuccessRegisterState extends RegisterStates {
  final LoginModel loginModel;

  SuccessRegisterState({
    required this.loginModel,
  });
}

class PasswordVisibilityRegisterState extends RegisterStates {}

class ErrorRegisterState extends RegisterStates {
  final String error;
  ErrorRegisterState({
    required this.error,
  });
}

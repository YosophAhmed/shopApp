import 'package:shop_app/models/login_model.dart';

abstract class LoginStates {}

class InitialLoginState extends LoginStates {}

class LoadingLoginState extends LoginStates {}

class SuccessLoginState extends LoginStates {
  final LoginModel loginModel;

  SuccessLoginState({
    required this.loginModel,
  });
}

class PasswordVisibilityLoginState extends LoginStates {}

class ErrorLoginState extends LoginStates {
  final String error;
  ErrorLoginState(this.error);
}

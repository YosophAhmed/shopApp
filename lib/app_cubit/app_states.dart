import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class AppState {}

class InitialState extends AppState {}

class ChangeBottomNavState extends AppState {}

class LoadingHomeDataState extends AppState {}

class SuccessHomeDataState extends AppState {}

class ErrorHomeDataState extends AppState {
  final String errorMessage;

  ErrorHomeDataState({
    required this.errorMessage,
  });
}

class LoadingCategoriesState extends AppState {}

class SuccessCategoriesState extends AppState {}

class ErrorCategoriesState extends AppState {
  final String errorMessage;

  ErrorCategoriesState({
    required this.errorMessage,
  });
}

class ChangeFavoriteState extends AppState {}

class SuccessChangeFavoriteState extends AppState {
  final FavoritesModel model;
  SuccessChangeFavoriteState({
    required this.model,
  });
}

class ErrorChangeFavoriteState extends AppState {
  final String errorMessage;

  ErrorChangeFavoriteState({
    required this.errorMessage,
  });
}

class LoadingGetFavoriteState extends AppState {}

class SuccessGetFavoriteState extends AppState {}

class ErrorGetFavoriteState extends AppState {
  final String errorMessage;

  ErrorGetFavoriteState({
    required this.errorMessage,
  });
}

class LoadingGetUserDataState extends AppState {}

class SuccessGetUserDataState extends AppState {
  final LoginModel loginModel;

  SuccessGetUserDataState({
    required this.loginModel,
  });
}

class ErrorGetUserDataState extends AppState {
  final String errorMessage;

  ErrorGetUserDataState({
    required this.errorMessage,
  });
}

class LoadingUpdateUserDataState extends AppState {}

class SuccessUpdateUserDataState extends AppState {
  final LoginModel loginModel;

  SuccessUpdateUserDataState({
    required this.loginModel,
  });
}

class ErrorUpdateUserDataState extends AppState {
  final String errorMessage;

  ErrorUpdateUserDataState({
    required this.errorMessage,
  });
}

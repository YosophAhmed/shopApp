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

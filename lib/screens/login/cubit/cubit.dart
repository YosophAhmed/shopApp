import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screens/login/cubit/states.dart';
import '../../../network/end_points.dart';
import 'package:flutter/material.dart';

class LoginCubit extends Cubit<LoginStates> {
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;

  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void changeSuffix() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(
      PasswordVisibilityLoginState(),
    );
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(
      LoadingLoginState(),
    );
    DioHelper.postData(
      url: loginUrl,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      
      print(value?.data);
      emit(
        SuccessLoginState(),
      );
    }).catchError((error) {
      print(error.toString());
      emit(
        ErrorLoginState(
          error.toString(),
        ),
      );
    });
  }
}

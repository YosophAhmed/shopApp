import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screens/login/cubit/states.dart';
import '../../../network/end_points.dart';
import 'package:flutter/material.dart';

class LoginCubit extends Cubit<LoginStates> {
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;

  late LoginModel loginModel;

  static LoginCubit get(context) => BlocProvider.of(context);


  LoginCubit() : super(InitialLoginState());


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
      loginModel = LoginModel.fromJson(value!.data);
      emit(
        SuccessLoginState(
          loginModel: loginModel,
        ),
      );
    }).catchError((error) {
      emit(
        ErrorLoginState(
          error.toString(),
        ),
      );
    });
  }
}

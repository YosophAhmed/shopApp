import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screens/register/cubit/register_states.dart';
import '../../../network/end_points.dart';
import 'package:flutter/material.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;

  late LoginModel loginModel;

  static RegisterCubit get(context) => BlocProvider.of(context);

  RegisterCubit() : super(InitialRegisterState());

  void changeSuffix() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(
      PasswordVisibilityRegisterState(),
    );
  }

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(
      LoadingRegisterState(),
    );
    DioHelper.postData(
      url: register,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value!.data);
      emit(
        SuccessRegisterState(
          loginModel: loginModel,
        ),
      );
    }).catchError((error) {
      emit(
        ErrorRegisterState(
          error: error.toString(),
        ),
      );
    });
  }
}

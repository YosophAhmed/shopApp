import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screens/login/cubit/states.dart';
import '../../../network/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

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
      emit(
        SuccessLoginState(),
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

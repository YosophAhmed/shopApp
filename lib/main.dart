import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/Register/register_screen.dart';
import 'package:shop_app/screens/login/login_screen.dart';
import 'package:shop_app/screens/onboarding/onboarding_screen.dart';
import 'bloc/bloc_observer.dart';
import 'constants/colors.dart';
import 'network/remote/dio_helper.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(
    const ShopApp(),
  );
}

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        primarySwatch: defaultColor,
        backgroundColor: Colors.white,
      ),
      initialRoute: OnBoardingScreen.routeName,
      routes: {
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/screens/Home/home_screen.dart';
import 'package:shop_app/screens/Register/register_screen.dart';
import 'package:shop_app/screens/login/login_screen.dart';
import 'package:shop_app/screens/onboarding/onboarding_screen.dart';
import 'bloc/bloc_observer.dart';
import 'constants/colors.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');

  String initialRoute;

  if (onBoarding == null) {
    initialRoute = OnBoardingScreen.routeName;
  } else {
    if (token == null) {
      initialRoute = LoginScreen.routeName;
    } else {
      initialRoute = HomeScreen.routeName;
    }
  }

  runApp(
    ShopApp(
      initialRoute: initialRoute,
    ),
  );
}

class ShopApp extends StatelessWidget {
  final String initialRoute;

  const ShopApp({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

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
      initialRoute: initialRoute,
      routes: {
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}

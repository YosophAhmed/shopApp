import 'package:flutter/material.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/screens/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Shopping',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 48,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            CacheHelper.removeData(
              key: 'token',
            ).then((value) {
              if (value) {
                Navigator.pushReplacementNamed(
                  context,
                  LoginScreen.routeName,
                );
              }
            });
          },
          child: const Text(
            'Sign Out',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}

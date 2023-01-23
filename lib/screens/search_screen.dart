import 'package:flutter/material.dart';
import 'package:shop_app/constants/colors.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = 'SearchScreen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Search ...',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 38,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: defaultColor,
            size: 36,
          ),
        ),
      ),
    );
  }
}

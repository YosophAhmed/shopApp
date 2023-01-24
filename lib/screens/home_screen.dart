import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/app_cubit/app_states.dart';
import 'package:shop_app/screens/search_screen.dart';
import 'package:shop_app/widgets/custom_search_icon.dart';

import '../constants/colors.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getHomeData()..getCategoriesData()..getFavoritesData(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
                  color: defaultColor,
                ),
                textAlign: TextAlign.center,
              ),
              actions: [
                CustomIcon(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      SearchScreen.routeName,
                    );
                  },
                  icon: Icons.search,
                ),
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeBottom(index: index);
              },
              currentIndex: cubit.currentIndex,
              selectedItemColor: defaultColor,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,
                  ),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: 'Favourites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// TextButton(
// onPressed: () {
// CacheHelper.removeData(
// key: 'token',
// ).then((value) {
// if (value) {
// Navigator.pushReplacementNamed(
// context,
// LoginScreen.routeName,
// );
// }
// });
// },
// child: const Text(
// 'Sign Out',
// style: TextStyle(
// fontSize: 24,
// ),
// ),
// )

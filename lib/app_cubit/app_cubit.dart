import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screens/categories.dart';
import 'package:shop_app/screens/favourites.dart';
import 'package:shop_app/screens/products.dart';
import 'package:shop_app/screens/settings.dart';

import '../network/end_points.dart';
import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  final List<Widget> bottomScreens = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom({
    required int index,
  }) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  final List<String> titles = [
    'All Products',
    'All Categories',
    'Favourites',
    'Settings',
  ];

  HomeModel? homeModel;

  Future<void> getHomeData() async {
    emit(LoadingHomeDataState());
    DioHelper.getData(
      url: home,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(SuccessHomeDataState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ErrorHomeDataState(
        errorMessage: error.toString(),
      ));
    });
  }

  void printFullText({
    required String text,
  }) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((element) {
      debugPrint(element.group(0));
    });
  }

  CategoriesModel? categoriesModel;

  Future<void> getCategoriesData() async {
    emit(LoadingCategoriesState());
    DioHelper.getData(
      url: allCategories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessCategoriesState());
    }).catchError((error) {
      emit(ErrorCategoriesState(
        errorMessage: error.toString(),
      ));
    });
  }

}

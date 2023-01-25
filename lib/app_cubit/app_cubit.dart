import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/get_favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screens/categories.dart';
import 'package:shop_app/screens/favourites.dart';
import 'package:shop_app/screens/products.dart';
import 'package:shop_app/screens/settings.dart';

import '../models/favorites_model.dart';
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
  Map<int, bool> favourites = {};

  Future<void> getHomeData() async {
    emit(LoadingHomeDataState());
    DioHelper.getData(
      url: home,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favourites.addAll({
          element.id: element.isFavourite,
        });
      });
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

  FavoritesModel? favoritesModel;

  void changeFavorite({
    required int productId,
  }) {
    favourites[productId] = !favourites[productId]!;
    emit(ChangeFavoriteState());
    DioHelper.postData(
      url: favorites,
      data: {
        'product_id': productId,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value!.data);
      if (!favoritesModel!.status) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavoritesData();
      }
      emit(SuccessChangeFavoriteState(
        model: favoritesModel!,
      ));
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      emit(ErrorChangeFavoriteState(errorMessage: error.toString()));
    });
  }

  GetFavoritesModel? getFavoritesModel;

  Future<void> getFavoritesData() async {
    emit(LoadingGetFavoriteState());
    DioHelper.getData(
      url: favorites,
      token: token,
    ).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      printFullText(text: getFavoritesModel.toString());
      emit(SuccessGetFavoriteState());
    }).catchError((error) {
      emit(ErrorGetFavoriteState(
        errorMessage: error.toString(),
      ));
    });
  }
}

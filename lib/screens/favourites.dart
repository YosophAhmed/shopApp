import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_states.dart';
import 'package:shop_app/models/get_favorites_model.dart';

import '../app_cubit/app_cubit.dart';
import '../constants/colors.dart';


class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! LoadingGetFavoriteState && cubit.getFavoritesModel != null,
          builder: (BuildContext context) {
            return FavoriteBuilder(
              model: cubit.getFavoritesModel!,
            );
          },
          fallback: (BuildContext context) {
            return const Center(
              child: Text(
                'No favorites',
                style: TextStyle(
                  fontSize: 32,
                  color: defaultColor,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class FavoriteBuilder extends StatelessWidget {
  final GetFavoritesModel model;

  const FavoriteBuilder({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: GridView.count(
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 1.5,
        mainAxisSpacing: 1.5,
        childAspectRatio: 1 / 1.51,
        children: List.generate(
          model.data.data.length,
          (index) => FavoriteItem(
            model: model.data.data[index].product,
          ),
        ),
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final Product model;

  const FavoriteItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image.network(
                model.image!,
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: const Text(
                    'Discount',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              model.name,
              style: const TextStyle(
                fontSize: 16,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (model.discount != 0)
                Text(
                  '${model.oldPrice.round()}',
                  style: const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              const SizedBox(
                width: 15,
              ),
              Text(
                '${model.price.round()}' + r' $',
                style: const TextStyle(
                  color: defaultColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeFavorite(productId: model.id);
                },
                icon: favouriteIcon(
                  context: context,
                  model: model,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget favouriteIcon({
  required Product model,
  required BuildContext context,
}) {
  return ConditionalBuilder(
    condition: AppCubit.get(context).favourites[model.id]!,
    builder: (context) => const Icon(
      Icons.favorite,
      color: Colors.red,
      size: 24,
    ),
    fallback: (context) => const Icon(
      Icons.favorite_border,
      size: 24,
    ),
  );
}


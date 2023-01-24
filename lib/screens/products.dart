import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/app_cubit/app_states.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/widgets/custom_circular_progress_indicator.dart';
import 'package:shop_app/widgets/show_toast.dart';

import '../widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is SuccessChangeFavoriteState) {
          if (!state.model.status) {
            showToast(
              message: state.model.message,
              state: ToastStates.error,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.homeModel != null,
          builder: (BuildContext context) {
            return ProductsBuilder(
              homeModel: cubit.homeModel!,
            );
          },
          fallback: (BuildContext context) {
            return const Center(
              child: CustomCircularProgressIndicator(
                color: defaultColor,
              ),
            );
          },
        );
      },
    );
  }
}

class ProductsBuilder extends StatelessWidget {
  final HomeModel homeModel;

  const ProductsBuilder({
    Key? key,
    required this.homeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: homeModel.data.banners.map((banner) {
              return Image(
                image: NetworkImage(banner.image),
                width: double.infinity,
                fit: BoxFit.fill,
              );
            }).toList(),
            options: CarouselOptions(
              enableInfiniteScroll: true,
              initialPage: 0,
              autoPlay: true,
              autoPlayInterval: const Duration(
                seconds: 3,
              ),
              autoPlayAnimationDuration: const Duration(
                seconds: 1,
              ),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              height: 250,
              viewportFraction: 1.0,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 1.5,
              mainAxisSpacing: 1.5,
              childAspectRatio: 1 / 1.51,
              children: List.generate(
                homeModel.data.products.length,
                (index) => ProductItem(
                  model: homeModel.data.products[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
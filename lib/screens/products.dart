import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/app_cubit/app_states.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/widgets/custom_circular_progress_indicator.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
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
    return Column(
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
      ],
    );
  }
}

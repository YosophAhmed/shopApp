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

class ProductItem extends StatelessWidget {
  final ProductsModel model;

  const ProductItem({
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
                model.image,
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
                padding: EdgeInsets.zero,
                onPressed: (){},
                icon: Icon(
                  Icons.favorite_border,
                  size: 24,
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

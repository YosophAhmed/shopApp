import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/app_cubit/app_states.dart';
import 'package:shop_app/models/categories_model.dart';

import '../constants/colors.dart';
import '../widgets/custom_circular_progress_indicator.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.categoriesModel != null,
          builder: (BuildContext context) {
            return CategoryBuilder(
              categoriesModel: cubit.categoriesModel!,
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

class CategoryBuilder extends StatelessWidget {
  final CategoriesModel categoriesModel;

  const CategoryBuilder({
    Key? key,
    required this.categoriesModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        color: Colors.grey[300],
        child: GridView.count(
          crossAxisCount: 1,
          mainAxisSpacing: 5,
          childAspectRatio: 3 / 2.7,
          physics: const BouncingScrollPhysics(),
          children: List.generate(
            categoriesModel.data.data.length,
            (index) => CategoryItem(
              category: categoriesModel.data.data[index],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final DataModel category;

  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Text(
            category.name,
            style: const TextStyle(
              color: defaultColor,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 40,
          ),
          Image.network(
            category.image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}

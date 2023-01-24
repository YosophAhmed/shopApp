import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../app_cubit/app_cubit.dart';
import '../models/home_model.dart';

Widget favouriteIcon({
  required ProductsModel model,
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
import 'package:flutter/material.dart';

import '../app_cubit/app_cubit.dart';
import '../constants/colors.dart';
import '../models/home_model.dart';
import 'favourite_icon.dart';

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

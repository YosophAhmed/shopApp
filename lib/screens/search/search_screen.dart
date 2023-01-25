import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/screens/search/search_cubit/search_cubit.dart';
import 'package:shop_app/screens/search/search_cubit/search_states.dart';
import 'package:shop_app/widgets/custom_text_form_feild.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = 'SearchScreen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text(
                'Search',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
                  color: defaultColor,
                ),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: defaultColor,
                  size: 36,
                ),
              ),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Column(
                  children: [
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      controller: searchController,
                      prefix: Icons.search,
                      hintText: 'Search Product',
                      keyboardType: TextInputType.text,
                      onSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          cubit.search(
                            text: searchController.text,
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: SearchBuilder(
                          model: cubit.searchModel!,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchBuilder extends StatelessWidget {
  final SearchModel model;

  const SearchBuilder({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 1.5,
      mainAxisSpacing: 1.5,
      childAspectRatio: 1 / 1.51,
      children: List.generate(
        model.data.data.length,
        (index) => SearchItem(
          model: model.data.data[index],
        ),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  final DataModel model;

  const SearchItem({
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
          Image.network(
            model.image!,
            width: double.infinity,
            height: 200,
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              model.name!,
              style: const TextStyle(
                fontSize: 16,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Center(
            child: Text(
              '${model.price.round()}' + r' $',
              style: const TextStyle(
                color: defaultColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

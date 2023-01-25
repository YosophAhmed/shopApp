import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/app_cubit/app_states.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/widgets/custom_button.dart';
import 'package:shop_app/widgets/custom_circular_progress_indicator.dart';
import 'package:shop_app/widgets/custom_text_form_feild.dart';

import '../network/local/cache_helper.dart';
import 'login/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        LoginModel loginModel = cubit.loginModel!;
        nameController.text = loginModel.data!.name;
        emailController.text = loginModel.data!.email;
        phoneController.text = loginModel.data!.phone;

        return ConditionalBuilder(
          condition: cubit.loginModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 20,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is LoadingUpdateUserDataState)
                    const LinearProgressIndicator(),
                  const Spacer(),
                  CustomTextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    hintText: 'Name',
                    prefix: Icons.person,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email',
                    prefix: Icons.email,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    hintText: 'Phone',
                    prefix: Icons.phone,
                  ),
                  const Spacer(),
                  CustomButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        cubit.updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    label: 'Update Account',
                    color: defaultColor,
                    height: 50,
                  ),
                  const Spacer(),
                  CustomButton(
                    label: 'Log Out',
                    color: defaultColor,
                    height: 50,
                    onTap: () {
                      CacheHelper.removeData(
                        key: 'token',
                      ).then((value) {
                        if (value) {
                          Navigator.pushReplacementNamed(
                            context,
                            LoginScreen.routeName,
                          );
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(
            child: CustomCircularProgressIndicator(
              color: defaultColor,
            ),
          ),
        );
      },
    );
  }
}

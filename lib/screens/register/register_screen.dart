import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/login/login_screen.dart';
import 'package:shop_app/screens/register/cubit/register_states.dart';

import '../../constants/colors.dart';
import '../../network/end_points.dart';
import '../../network/local/cache_helper.dart';
import '../../widgets/show_toast.dart';
import '../home_screen.dart';
import 'cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'RegisterScreen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is SuccessRegisterState) {
            if (state.loginModel.status) {
              showToast(
                message: state.loginModel.message,
                state: ToastStates.success,
              );
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                Navigator.pushReplacementNamed(
                  context,
                  HomeScreen.routeName,
                );
              });
            } else {
              showToast(
                message: state.loginModel.message,
                state: ToastStates.error,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.grey),
                        ),
                        Text(
                          'register now to browse hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name is required';
                            }
                          },
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone is required';
                            }
                          },
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter vaild email';
                            }
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            }
                          },
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: RegisterCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            labelText: 'password',
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                RegisterCubit.get(context).changeSuffix();
                              },
                              icon: Icon(
                                RegisterCubit.get(context).suffix,
                              ),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoadingRegisterState,
                          builder: (context) => Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: defaultColor,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      if(formKey.currentState!.validate()) {
                                        RegisterCubit.get(context).userRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          name: nameController.text,
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'You have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  LoginScreen.routeName,
                                );
                              },
                              child: const Text(
                                'Login Now',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

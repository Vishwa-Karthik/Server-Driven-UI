

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:server_driven_ui/core/injections/injection.dart';
import 'package:server_driven_ui/core/utils/app_strings.dart';
import 'package:server_driven_ui/core/utils/component_factory.dart';
import 'package:server_driven_ui/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:server_driven_ui/features/login/presentation/bloc/login_bloc.dart';
import 'package:server_driven_ui/features/sign_up/presentation/pages/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late final LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = sl<LoginBloc>();
    fetchRemoteConfig();
  }

  void fetchRemoteConfig() async {
    loginBloc.add(FetchRemoteConfig(screenId: AppString.loginScreen));
  }

  void onLoginPressed() {
    if (formKey.currentState!.validate()) {
      loginBloc.add(
        LoginButtonPressed(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<LoginBloc, LoginState>(
          bloc: loginBloc,
          listener: (context, state) {
            if (state is LoginSuccess) {
              if (state.message == AppString.remoteConfigFetched) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardPage(),
                  ),
                );
              }
            }
          },
          builder: (context, state) {
            if (state is LoginSuccess) {
              final List<dynamic> components =
                  state.remoteConfigData!['body'] ?? [];
              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      components.map<Widget>((component) {
                        return ComponentFactory.buildComponent(
                          component,
                          context,
                          formKey: formKey,
                          onEvent: (id, value) {
                            if (id == 'email') {
                              emailController.text = value;
                            } else if (id == 'password') {
                              passwordController.text = value;
                            } else if (id == 'log_in') {
                              if (emailController.text.isEmpty ||
                                  passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please fill all fields"),
                                  ),
                                );
                                return;
                              }
                              loginBloc.add(
                                LoginButtonPressed(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                            } else if (id == 'navigate') {
                              if (value == 'sign_up_screen') {
                                Navigator.pushReplacement(
                                  context,
                                  SignUpPage.route(),
                                );
                              }
                            }
                          },
                        );
                      }).toList(),
                ),
              );
            } else if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('Error fetching data'));
            }
          },
        ),
      ),
    );
  }
}

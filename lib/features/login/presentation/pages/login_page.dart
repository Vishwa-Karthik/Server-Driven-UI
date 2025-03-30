// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:server_driven_ui/core/injections/injection.dart';
// import 'package:server_driven_ui/core/utils/app_strings.dart';
// import 'package:server_driven_ui/core/utils/component_factory.dart';
// import 'package:server_driven_ui/features/dashboard/presentation/pages/dashboard_page.dart';
// import 'package:server_driven_ui/features/login/presentation/bloc/login_bloc.dart';

// class LoginPage extends StatefulWidget {
//   static route() => MaterialPageRoute(builder: (context) => const LoginPage());

//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   late final LoginBloc loginBloc;

//   @override
//   void initState() {
//     super.initState();
//     loginBloc = sl<LoginBloc>();
//     fetchRemoteConfig();
//   }

//   void fetchRemoteConfig() async {
//     loginBloc.add(FetchRemoteConfig(screenId: AppString.loginScreen));
//   }

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: BlocConsumer<LoginBloc, LoginState>(
//           bloc: loginBloc,
//           listener: (context, state) {
//             if (state is LoginSuccess) {
//               if (state.message == AppString.remoteConfigFetched) {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const DashboardPage(),
//                   ),
//                 );
//               }
//             } else if (state is LoginFailure) {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(state.error)));
//             }
//           },
//           builder: (context, state) {
//             if (state is LoginSuccess) {
//               final List<dynamic> components =
//                   state.remoteConfigData!['body'] ?? [];
//               return Form(
//                 key: formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children:
//                       components
//                           .map<Widget>(
//                             (component) => ComponentFactory.buildComponent(
//                               component,
//                               context,
//                               formKey: formKey,
//                             ),
//                           )
//                           .toList(),
//                 ),
//               );
//             } else if (state is LoginLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else {
//               return const Center(child: Text('Error fetching data'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:server_driven_ui/core/injections/injection.dart';
// import 'package:server_driven_ui/core/utils/app_colors.dart';
// import 'package:server_driven_ui/core/utils/app_strings.dart';
// import 'package:server_driven_ui/core/utils/component_factory.dart';
// import 'package:server_driven_ui/features/dashboard/presentation/pages/dashboard_page.dart';
// import 'package:server_driven_ui/features/login/presentation/bloc/login_bloc.dart';

// class LoginPage extends StatefulWidget {
//   static route() => MaterialPageRoute(builder: (context) => const LoginPage());

//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   late final LoginBloc loginBloc;
//   List<dynamic> components = [];

//   @override
//   void initState() {
//     super.initState();
//     loginBloc = sl<LoginBloc>();
//     fetchRemoteConfig();
//   }

//   void fetchRemoteConfig() {
//     loginBloc.add(FetchRemoteConfig(screenId: AppString.loginScreen));
//   }

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: BlocConsumer<LoginBloc, LoginState>(
//           bloc: loginBloc,
//           listener: (context, state) {
//             if (state is LoginSuccess) {
//               if (state.message == AppString.remoteConfigFetched) {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const DashboardPage(),
//                   ),
//                 );
//               }
//             } else if (state is LoginFailure) {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(state.error)));
//             }
//           },
//           builder: (context, state) {
//             if (state is LoginSuccess) {
//               components = state.remoteConfigData!['body'] ?? [];

//               return Form(
//                 key: formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children:
//                       components.map<Widget>((component) {
//                         switch (component['type']) {
//                           case 'text':
//                             return TextComponent(
//                               text: component['value'] ?? '',
//                               fontSize: component['fontSize']?.toDouble() ?? 16,
//                               color:
//                                   AppColors.parseColor(
//                                     component['color'] as String,
//                                   ) ??
//                                   Colors.white,
//                               // alignment: component['alignment'],
//                             );

//                           case 'textField':
//                             return TextFieldComponent(
//                               controller:
//                                   component['fieldName'] == 'email'
//                                       ? emailController
//                                       : passwordController,
//                               // hintText: component['placeholder'],
//                               obscureText: component['obscureText'] ?? false,
//                               onChanged: (value) {
//                                 if (component['fieldName'] == 'email') {
//                                   emailController.text = value;
//                                 } else if (component['fieldName'] ==
//                                     'password') {
//                                   passwordController.text = value;
//                                 }
//                               },
//                             );

//                           case 'button':
//                             return ButtonComponent(
//                               action: component['action'],
//                               label: component['label'] ?? 'Submit',
//                               backgroundColor:
//                                   AppColors.parseColor(
//                                     component['backgroundColor'],
//                                   ) ??
//                                   Colors.red,
//                               textColor:
//                                   AppColors.parseColor(
//                                     component['textColor'],
//                                   ) ??
//                                   Colors.white,
//                               onAction: (context, action, target) {
//                                 loginBloc.add(
//                                   LoginButtonPressed(
//                                     email: emailController.text,
//                                     password: passwordController.text,
//                                   ),
//                                 );
//                               },
//                             );

//                           default:
//                             return const SizedBox.shrink();
//                         }
//                       }).toList(),
//                 ),
//               );
//             } else if (state is LoginLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else {
//               return const Center(child: Text('Error fetching data'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

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

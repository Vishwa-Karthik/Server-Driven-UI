import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:server_driven_ui/core/injections/injection.dart';
import 'package:server_driven_ui/core/utils/app_strings.dart';
import 'package:server_driven_ui/core/utils/component_factory.dart';
import 'package:server_driven_ui/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:server_driven_ui/main.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late final SignUpBloc signUpBloc;

  @override
  void initState() {
    super.initState();
    signUpBloc = sl<SignUpBloc>();
    fetchRemoteConfig();
  }

  void fetchRemoteConfig() async {
    signUpBloc.add(FetchRemoteConfig(screenId: AppString.signUpScreen));
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
      body: BlocConsumer<SignUpBloc, SignUpState>(
        bloc: signUpBloc,
        listener: (context, state) {
          if (state is SignUpSuccess) {
            if (state.message == AppString.remoteConfigFetched) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashBoard()),
              );
            }
          } else if (state is SignUpFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is SignUpSuccess) {
            final List<dynamic> components =
                state.remoteConfigData!['body'] ?? [];
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    components
                        .map<Widget>(
                          (component) => ComponentFactory.buildComponent(
                            component,
                            context,
                            formKey: formKey,
                          ),
                        )
                        .toList(),
              ),
            );
          } else if (state is SignUpLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Error fetching data'));
          }
        },
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:server_driven_ui/core/injections/injection.dart';
import 'package:server_driven_ui/core/remote_config/firebase_remote_config.dart';
import 'package:server_driven_ui/core/utils/app_strings.dart';
import 'package:server_driven_ui/core/utils/app_theme.dart';
import 'package:server_driven_ui/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:server_driven_ui/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:server_driven_ui/features/login/domain/repositories/abstract_firebase_login.dart';
import 'package:server_driven_ui/features/login/presentation/bloc/login_bloc.dart';
import 'package:server_driven_ui/features/login/presentation/pages/login_page.dart';
import 'package:server_driven_ui/features/sign_up/domain/repositories/abstract_firebase_sign_up.dart';
import 'package:server_driven_ui/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:server_driven_ui/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Injection.init();
  final appTheme = await sl<FirebaseRemoteConfigMethod>().fetchScreenJson(
    screenId: AppString.appTheme,
  );
  runApp(MyApp(appTheme: appTheme));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic>? appTheme;

  const MyApp({super.key, this.appTheme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Server Driven User Interface',
      theme: AppTheme(appTheme: appTheme).lightTheme,
      darkTheme: AppTheme(appTheme: appTheme).darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) =>
                    LoginBloc(firebaseLogin: sl<AbstractFirebaseLogin>()),
          ),

          BlocProvider(
            create:
                (context) =>
                    SignUpBloc(firebaseSignUp: sl<AbstractFirebaseSignUp>()),
          ),
          BlocProvider(create: (context) => DashboardBloc()),
        ],
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.idTokenChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return const DashboardPage();
            }
            return LoginPage();
          },
        ),
      ),
    );
  }
}

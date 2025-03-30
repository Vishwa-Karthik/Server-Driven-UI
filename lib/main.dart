
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:server_driven_ui/core/injections/injection.dart';
import 'package:server_driven_ui/core/remote_config/firebase_remote_config.dart';
import 'package:server_driven_ui/core/utils/app_strings.dart';
import 'package:server_driven_ui/core/utils/app_theme.dart';
import 'package:server_driven_ui/features/home/presentation/pages/home_page.dart';
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
        ],
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return const DashBoard();
            }
            return LoginPage();
          },
        ),
      ),
    );
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final pages = [
    HomePage(),
    const Center(child: Text('Search')),
    const Center(child: Text('Profile')),
  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Server Driven UI'), centerTitle: true),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}

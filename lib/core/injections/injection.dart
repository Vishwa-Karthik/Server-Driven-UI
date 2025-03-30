import 'package:get_it/get_it.dart';
import 'package:server_driven_ui/core/remote_config/firebase_remote_config.dart';
import 'package:server_driven_ui/features/login/data/repositories/firebase_login_impl.dart';
import 'package:server_driven_ui/features/login/domain/repositories/abstract_firebase_login.dart';
import 'package:server_driven_ui/features/login/presentation/bloc/login_bloc.dart';
import 'package:server_driven_ui/features/sign_up/data/repositories/firebase_sign_up_impl.dart';
import 'package:server_driven_ui/features/sign_up/domain/repositories/abstract_firebase_sign_up.dart';
import 'package:server_driven_ui/features/sign_up/presentation/bloc/sign_up_bloc.dart';

final GetIt sl = GetIt.instance;

class Injection {
  static void init() {
    // bloc
    sl.registerFactory<SignUpBloc>(
      () => SignUpBloc(firebaseSignUp: sl<AbstractFirebaseSignUp>()),
    );
    sl.registerFactory<LoginBloc>(
      () => LoginBloc(firebaseLogin: sl<AbstractFirebaseLogin>()),
    );

    // repository
    sl.registerLazySingleton<AbstractFirebaseSignUp>(
      () => FirebaseSignUpImpl(),
    );
    sl.registerLazySingleton<AbstractFirebaseLogin>(() => FirebaseLoginImpl());

    //
    sl.registerLazySingleton(() => FirebaseRemoteConfigMethod());
  }
}

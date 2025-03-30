import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:server_driven_ui/core/injections/injection.dart';
import 'package:server_driven_ui/core/remote_config/firebase_remote_config.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<FetchRemoteConfig>(onFetchRemoteConfig);
  }

  FutureOr<void> onFetchRemoteConfig(
    FetchRemoteConfig event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final result = await sl<FirebaseRemoteConfigMethod>().fetchScreenJson(
        screenId: event.screenId,
      );
      log(result.toString(), name: 'Remote Config');
      emit(DashboardSuccess(remoteConfigData: result));
    } catch (e) {
      emit(DashboardFailure(error: e.toString()));
    }
  }
}

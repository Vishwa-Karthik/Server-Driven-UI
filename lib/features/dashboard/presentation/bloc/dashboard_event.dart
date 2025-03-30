part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class FetchRemoteConfig extends DashboardEvent {
  final String screenId;

  const FetchRemoteConfig({required this.screenId});

  @override
  List<Object> get props => [screenId];
}

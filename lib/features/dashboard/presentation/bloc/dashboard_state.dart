part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final Map<String, dynamic> remoteConfigData;

  const DashboardSuccess({required this.remoteConfigData});

  @override
  List<Object> get props => [remoteConfigData];
}

class DashboardFailure extends DashboardState {
  final String error;

  const DashboardFailure({required this.error});

  @override
  List<Object> get props => [error];
}

part of 'launcher_cubit.dart';

sealed class LauncherState extends Equatable {
  const LauncherState();

  @override
  List<Object> get props => [];
}

final class LauncherInitial extends LauncherState {}

final class LauncherAuthenticated extends LauncherState {}

class LauncherUnauthenticated extends LauncherState {}

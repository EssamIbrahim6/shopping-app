part of 'hello_cubit.dart';

sealed class HelloState {}

final class HelloInitial extends HelloState {}

class HelloLoading extends HelloState {}

class HelloMarkedAsVisited extends HelloState {}

final class HelloVisited extends HelloState {
  HelloVisited(this.hasVisited);
  final bool hasVisited;
}

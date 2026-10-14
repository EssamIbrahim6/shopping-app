import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future<T?> push<T>(Widget page) {
    return Navigator.push<T>(this, MaterialPageRoute(builder: (_) => page));
  }

  Future<T?> pushReplacement<T, TO>(Widget page) {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<T?> pushAndRemoveAll<T>(Widget page) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(builder: (_) => page),
      (_) => false,
    );
  }

  void pop<T extends Object?>([T? result]) {
    Navigator.pop(this, result);
  }

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(this, routeName, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed<T, TO>(
      this,
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      this,
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  PageRoute<T> _slideRoute<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, _, _) => page,
      transitionDuration: duration,
      transitionsBuilder: (_, animation, _, child) {
        return SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)),
          ),
          child: child,
        );
      },
    );
  }

  Future<T?> pushWithAnimation<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return Navigator.of(
      this,
    ).push<T>(_slideRoute(page, duration: duration, curve: curve));
  }

  Future<T?> pushReplacementWithAnimation<T, TO>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return Navigator.of(this).pushReplacement<T, TO>(
      _slideRoute(page, duration: duration, curve: curve),
    );
  }

  Future<T?> pushAndRemoveAllWithAnimation<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      _slideRoute(page, duration: duration, curve: curve),
      (_) => false,
    );
  }
}

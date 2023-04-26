import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import 'features/login/login_screen.dart';

@singleton
class NavigationService {
  final navigatorKey = GlobalKey<NavigatorState>();

  bool isPopupShown = false;

  NavigatorState get _navigator => navigatorKey.currentState!;

  Future<dynamic> navigateTo(String routeName) {
    return _navigator.pushNamed(routeName);
  }

  Future<dynamic> navigateToWithArgument<T>(String routeName, T data) {
    return _navigator.pushNamed(routeName, arguments: data);
  }

  void pop() {
    return _navigator.pop();
  }

  Future<dynamic> showLogin() {
    return _navigator.pushAndRemoveUntil<void>(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
          (route) => false,
    );
  }
  
  Future<T?> pushAndRemoveUntil<T extends Object?>(Route<T> newRoute, RoutePredicate predicate) {
    return _navigator.pushAndRemoveUntil(newRoute, predicate);
  }


}

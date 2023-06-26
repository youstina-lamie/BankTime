import 'package:flutter/material.dart';


class AppNavigator {
  AppNavigator._();

  static final appGlobalKey = GlobalKey<ScaffoldState>();

  static BuildContext get globalContext {
    final context = appGlobalKey.currentContext;

    if (context == null) {
      throw Exception('Navigation failed,appGlobalKey returns a null context');
    }
    return context;
  }

  static Future<T?> globalPush<T extends Object?>(Route<T> route) {
    return Navigator.of(globalContext).push(route);
  }

  static Future<T?> globalPushAndClearAll<T extends Object?>(Route<T> route) {
    return Navigator.of(globalContext).pushAndRemoveUntil(
      route,
      (Route<dynamic> route) => false,
    );
  }
}

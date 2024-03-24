import 'dart:developer';

import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class NavigationMiddleware {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationMiddleware(this.navigatorKey);

  Function create() {
    return _navigateMiddleware;
  }

  _navigateMiddleware(Store<AppState> store, action, NextDispatcher next) {

    if(action is NavigateAction) {
      if(navigatorKey?.currentState != null) {
        debugPrint("Navigation initialized");
        navigatorKey.currentState.pushNamed(action.route);
      } else {
        debugPrint("Navigation not initialized");
      }
    }
    if (action is NavigationClearAllPages) {
      if (navigatorKey?.currentState != null) {
        debugPrint("Navigation initialized");
        navigatorKey.currentState.pushNamedAndRemoveUntil(action.route, (Route<dynamic> route) => false);
      } else {
        debugPrint("Navigation not initialized");
      }
    }
    next(action);
  }
}

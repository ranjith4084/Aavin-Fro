// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:developer';

import 'package:aavinposfro/actions/auth_actions.dart';
import 'package:aavinposfro/models/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

final authReducer = combineReducers<AppState>([
  TypedReducer<AppState, AuthStateChangeAction>(updateAuthState),
]);

AppState updateAuthState(AppState state, AuthStateChangeAction action) {
  log("updateAuthState");
  var appState;
  appState = state.copyWith(currentUser: Optional.fromNullable(action.user));
  return appState;

}



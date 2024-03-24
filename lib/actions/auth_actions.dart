
import 'package:firebase_auth/firebase_auth.dart';

class AuthStateChangeAction {
  final User user;
  AuthStateChangeAction(this.user);
}

class AuthSignOutAction {
}
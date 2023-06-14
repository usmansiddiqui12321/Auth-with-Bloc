import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthCodeSentState extends AuthStates {}

class AuthCodeVerifiedState extends AuthStates {}

class AuthLoggedInState extends AuthStates {
  final User firebaseUser;
  AuthLoggedInState({required this.firebaseUser});
}

class AuthLoggedOutState extends AuthStates {}

class AuthErrorState extends AuthStates {
  final String error;

  AuthErrorState(this.error);
}

// ignore_for_file: non_constant_identifier_names

import 'package:auth_with_bloc/Cubit/PhoneAuthCubit/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthCubit() : super(AuthInitialState());
  String? _verificationId;
  void SendOtp({required String phoneNumber}) async {
    emit(AuthLoadingState());
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        // ! Code Send Hojata h tw Verification ID mil Jati h
        emit(AuthCodeSentState());
        _verificationId = verificationId;
      },
      verificationCompleted: (phoneAuthCredential) {
        SignInWithPhone(phoneAuthCredential: phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(AuthErrorState(error.message.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }
// 
  void VerifyOtp({required String otp}) async {
    emit(AuthLoadingState());

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otp,
    );
    SignInWithPhone(phoneAuthCredential: credential);
  }

  void SignInWithPhone(
      {required PhoneAuthCredential phoneAuthCredential}) async {
    try {
      UserCredential userCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      if (userCredential.user != null) {
        emit(AuthLoggedInState(firebaseUser: userCredential.user!));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.message.toString()));
    }
  }
}

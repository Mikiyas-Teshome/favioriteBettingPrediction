// auth_bloc.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants/url_constants.dart';
import '../../services/auth_services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final GlobalKey<NavigatorState> navigatorKey;
  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email', 'profile' // Add required scopes (e.g., profile, contacts)
  //   ],
  // );

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: 'your-client_id.apps.googleusercontent.com',
    scopes: [
      'email',
      'profile',
    ],
  );
  AuthBloc(this.authService, {required this.navigatorKey})
      : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignUpEvent>(_onSignUp);
    on<EmailResendEvent>(_onEmailResend);
    on<OtpVerifyEvent>(_onOtpVerify);
    on<GoogleSignInEvent>(_onGoogleSignIn);
    on<PassResetEmailSendEvent>(_onPassResetEmailSend);
    on<ResetPassOtpVerifyEvent>(_onResetPassOtpVerify);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  void _onGoogleSignIn(GoogleSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await authService.verifyGoogleSignIn(idToken: event.idToken);
      emit(AuthAuthenticated());
      navigatorKey.currentState?.pushReplacementNamed('/home');
    } on ApiException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Unexpected error occurred'));
    }
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.login(event.email, event.password);
      emit(AuthAuthenticated());
      navigatorKey.currentState?.pushReplacementNamed('/home');
    } on ApiException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Unexpected error occurred'));
    }
  }

  void _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.signUp(
          email: event.email,
          password: event.password,
          firstName: event.firstname,
          lastName: event.lastname);
      emit(AuthSignUpSuccess());
      // navigatorKey.currentState?.pushReplacementNamed('/otp_verification');
    } on ApiException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Unexpected error occurred'));
    }
  }

  void _onEmailResend(EmailResendEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.emailResend(
        email: event.email,
      );
      emit(AuthEmailResendSuccess());
      navigatorKey.currentState?.pushReplacementNamed('/otp_verification');
    } on ApiException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Unexpected error occurred'));
    }
  }

  void _onPassResetEmailSend(
      PassResetEmailSendEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.passResetEmailSend(
        email: event.email,
      );
      emit(AuthPassResetEmailSendSuccess());
      // navigatorKey.currentState?.pushReplacementNamed('/otp_verification');
    } on ApiException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Unexpected error occurred'));
    }
  }

  void _onOtpVerify(OtpVerifyEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.otpVerify(email: event.email, otp: event.otp);
      emit(AuthOtpVerificationSuccess());
      navigatorKey.currentState?.pushReplacementNamed('/otp_verification');
    } on ApiException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Unexpected error occurred'));
    }
  }

  void _onResetPassOtpVerify(
      ResetPassOtpVerifyEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.resetPassOtpVerify(email: event.email, otp: event.otp);
      emit(AuthResetPassOtpVerificationSuccess());
    } on ApiException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Unexpected error occurred'));
    }
  }

  void _onResetPassword(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.resetPassword(
          email: event.email, password: event.password, tocken: event.token);
      emit(AuthResetPasswordSuccess());
    } on ApiException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Unexpected error occurred'));
    }
  }
}

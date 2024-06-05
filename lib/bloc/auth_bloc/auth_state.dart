// auth_state.dart
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

// class AuthData extends Equatable {
//   final String token;
//   final Map<String, dynamic> userData;
//
//   AuthData(this.token, this.userData);
//
//   @override
//   List<Object?> get props => [token, userData];
// }
//
// abstract class AuthState extends Equatable {
//   const AuthState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class AuthInitial extends AuthState {}
//
// class AuthLoading extends AuthState {}
//
// class AuthAuthenticated extends AuthState {
//   final AuthData authData;
//
//   AuthAuthenticated(this.authData);
//
//   @override
//   List<Object?> get props => [authData];
// }
//
// class AuthFailure extends AuthState {
//   final String error;
//
//   AuthFailure(this.error);
//
//   @override
//   List<Object?> get props => [error];
// }
//
// class SignUpLoading extends AuthState {}
//
// class SignUpSuccess extends AuthState {}
//
// class SignUpFailure extends AuthState {
//   final String error;
//
//   const SignUpFailure(this.error);
//
//   @override
//   List<Object?> get props => [error];
// }
class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthEmailVerificationRequired extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthSignUpSuccess extends AuthState {}

class AuthEmailResendSuccess extends AuthState {}

class AuthPassResetEmailSendSuccess extends AuthState {}

class AuthOtpVerificationSuccess extends AuthState {}

class AuthResetPassOtpVerificationSuccess extends AuthState {}

class AuthResetPasswordSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class GoogleSignInSuccess extends AuthState {
  // final GoogleSignInAccount account;
  //
  // const GoogleSignInSuccess(this.account);
  //
  // @override
  // List<Object> get props => [account];
}

class GoogleSignInFailure extends AuthState {
  final String error;

  const GoogleSignInFailure(this.error);

  @override
  List<Object> get props => [error];
}

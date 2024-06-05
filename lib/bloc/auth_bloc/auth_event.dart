// auth_event.dart
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String firstname;
  final String lastname;

  const SignUpEvent(
      {required this.email,
      required this.password,
      required this.firstname,
      required this.lastname});

  @override
  List<Object?> get props => [email, password, firstname, lastname];
}

class EmailResendEvent extends AuthEvent {
  final String email;

  const EmailResendEvent({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

class PassResetEmailSendEvent extends AuthEvent {
  final String email;

  const PassResetEmailSendEvent({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

class OtpVerifyEvent extends AuthEvent {
  final String email;
  final String otp;

  const OtpVerifyEvent({
    required this.email,
    required this.otp,
  });

  @override
  List<Object?> get props => [email, otp];
}

class ResetPassOtpVerifyEvent extends AuthEvent {
  final String email;
  final String otp;

  const ResetPassOtpVerifyEvent({
    required this.email,
    required this.otp,
  });

  @override
  List<Object?> get props => [email, otp];
}

class ResetPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  final String token;

  const ResetPasswordEvent({
    required this.email,
    required this.password,
    required this.token,
  });

  @override
  List<Object?> get props => [email, password, token];
}

// class GoogleSignInEvent extends AuthEvent {}
class GoogleSignInEvent extends AuthEvent {
  final String idToken;

  GoogleSignInEvent(this.idToken);

  @override
  List<Object?> get props => [idToken];
}

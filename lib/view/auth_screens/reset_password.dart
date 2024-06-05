import 'package:dio/dio.dart';
import 'package:faviorite_app/view/auth_screens/login_screen.dart';
import 'package:faviorite_app/view/auth_screens/otp_verification_screen.dart';
import 'package:faviorite_app/view/auth_screens/otp_verified_screen.dart';
import 'package:faviorite_app/view/widgets/custom_icon_button.dart';
import 'package:faviorite_app/view/widgets/custom_password_form_field.dart';
import 'package:faviorite_app/view/widgets/custom_rounded_button.dart';
import 'package:faviorite_app/view/widgets/custom_rounded_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/auth_bloc/auth_event.dart';
import '../../bloc/auth_bloc/auth_state.dart';
import '../../constants/color_constants.dart';
import '../../services/auth_services/auth_service.dart';
import 'confirm_email_screen.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  const ResetPassword({
    super.key,
    required this.email,
  });

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _confirmObscureText = true;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final AuthService authService = AuthService(Dio(), FlutterSecureStorage());

  // Create instance of AuthService
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is AuthResetPasswordSuccess) {
            // Handle sign-up success, e.g., show success message
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text('Sign up successful')));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                    create: (context) =>
                        AuthBloc(authService, navigatorKey: navigatorKey),
                    child: OtpVerifiedScreen(
                      isPassReset: true,
                    ),
                  );
                },
              ),
            );
          }
        },
        builder: (context, state) {
          // if (state is AuthLoading) {
          //   return Center(child: CircularProgressIndicator());
          // } else {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.09,
                  horizontal: MediaQuery.of(context).size.width * 0.075,
                ),
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      Theme.of(context).brightness == Brightness.light
                          ? 'assets/logo.svg'
                          : 'assets/logoDark.svg',
                      semanticsLabel: 'SVG Image',
                      placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(
                      height: 60.0,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                          fontFamily: "PilatExtended",
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomPasswordFormField(
                            hintText: 'Password',
                            borderRadius: 200,
                            borderColor: primaryColor,
                            controller: _passwordController,
                            obscureText: _obscureText,
                            onToggle: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomPasswordFormField(
                            hintText: 'Confirm Password',
                            borderRadius: 200,
                            borderColor: primaryColor,
                            controller: _confirmPasswordController,
                            obscureText: _confirmObscureText,
                            onToggle: () {
                              setState(() {
                                _confirmObscureText = !_confirmObscureText;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }
                              if (value != _passwordController.text) {
                                return "Passwords doesn\'t match";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomRoundedButton(
                            text: "Continue",
                            isLoading: state is AuthLoading,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final token = await authService.getToken();

                                // print("tokennn: " + token!);
                                BlocProvider.of<AuthBloc>(context).add(
                                  ResetPasswordEvent(
                                      password: _passwordController.text,
                                      email: widget.email,
                                      token: token!),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    // ElevatedButton(
                    //   onPressed:
                    //   child: Text('Login'),
                    // ),
                  ],
                ),
              ),
            ),
          );
          // }
        },
      ),
    );
  }
}

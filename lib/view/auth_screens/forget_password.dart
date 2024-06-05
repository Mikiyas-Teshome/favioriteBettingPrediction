import 'package:dio/dio.dart';
import 'package:faviorite_app/view/auth_screens/confirm_email_screen.dart';
import 'package:faviorite_app/view/auth_screens/forget_password.dart';
import 'package:faviorite_app/view/auth_screens/otp_verification_screen.dart';
import 'package:faviorite_app/view/auth_screens/sign_up_screen.dart';
import 'package:faviorite_app/view/screens/landing_page_screen.dart';
import 'package:faviorite_app/view/widgets/custom_icon_button.dart';
import 'package:faviorite_app/view/widgets/custom_password_form_field.dart';
import 'package:faviorite_app/view/widgets/custom_rounded_button.dart';
import 'package:faviorite_app/view/widgets/custom_rounded_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
import '../widgets/custom_dialog.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final AuthService authService = AuthService(
      Dio(), FlutterSecureStorage()); // Create instance of AuthService

  // final TelegramLogin telegramLogin = TelegramLogin(<PHONE_NUMBER:String>, <BOT_ID:String>, <BOT_DOMAIN:String>);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            if (state.error == "please verify your email") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) =>
                          AuthBloc(authService, navigatorKey: navigatorKey),
                      child: ConfirmEmailScreen(
                        email: _emailController.text,
                      ),
                    );
                  },
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          } else if (state is AuthPassResetEmailSendSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                    create: (context) =>
                        AuthBloc(authService, navigatorKey: navigatorKey),
                    child: OtpVerificationScreen(
                      email: _emailController.text,
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
                      height: 55.0,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Forget Password",
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
                          CustomRoundedTextFormField(
                            hintText: "Email",
                            borderRadius: 200.0,
                            borderColor: primaryColor,
                            controller: _emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is required';
                              } else if (!(RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(value))) {
                                return 'Enter valid email';
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final email = _emailController.text;
                                BlocProvider.of<AuthBloc>(context).add(
                                  PassResetEmailSendEvent(
                                    email: email,
                                  ),
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

import 'package:dio/dio.dart';
import 'package:faviorite_app/bloc/nav_bloc/nav_bloc.dart';
import 'package:faviorite_app/view/auth_screens/confirm_email_screen.dart';
import 'package:faviorite_app/view/auth_screens/forget_password.dart';
import 'package:faviorite_app/view/auth_screens/reset_password.dart';
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
import 'package:flutter/rendering.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool _obscureText = true;

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
          } else if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                    create: (context) => NavBloc(),
                    child: LandingPageScreen(),
                  );
                },
              ),
            );
          } else if (state is GoogleSignInSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                    create: (context) => NavBloc(),
                    child: LandingPageScreen(),
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
                        "Sign In",
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
                          const SizedBox(height: 20),
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
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return BlocProvider(
                                  create: (context) => AuthBloc(authService,
                                      navigatorKey: navigatorKey),
                                  child: ForgetPassword(),
                                );
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "Forget Password?",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17,
                              color: primaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomRoundedButton(
                            text: "Sigin In",
                            isLoading: state is AuthLoading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final email = _emailController.text;
                                final password = _passwordController.text;
                                BlocProvider.of<AuthBloc>(context).add(
                                  LoginEvent(email: email, password: password),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomIconButton(
                      text: "Continue with Google",
                      onPressed: () async {
                        const List<String> scopes = <String>[
                          'email',
                          'https://www.googleapis.com/auth/contacts.readonly',
                        ];

                        final GoogleSignIn _googleSignIn = GoogleSignIn(
                          // Optional clientId
                          clientId:
                              "909787354571-3b9hn2jiu74ecr5kjga02auunhurgdf2.apps.googleusercontent.com",
                          scopes: scopes,
                        );
                        try {
                          final GoogleSignInAccount? googleUser =
                              await _googleSignIn.signIn();
                          final GoogleSignInAuthentication googleAuth =
                              await googleUser!.authentication;
                          final idToken = googleAuth.idToken;
                          if (idToken != null) {
                            // print("idToken: " + idToken);
                            BlocProvider.of<AuthBloc>(context)
                                .add(GoogleSignInEvent(idToken));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Failed to sign in with Google else error')));
                          }
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Failed to sign in with Google' +
                                  error.toString())));
                        }
                      },
                      image: "assets/googleIcon.png",
                    ),

                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "You don\'t have account? ",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, '/sign_up');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return BlocProvider(
                                    create: (context) => AuthBloc(authService,
                                        navigatorKey: navigatorKey),
                                    child: SignUpScreen(),
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontFamily: "PilatExtended",
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Continue as a Guest? ",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return BlocProvider(
                                    create: (context) => NavBloc(),
                                    child: LandingPageScreen(),
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                                fontFamily: "PilatExtended",
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    )
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

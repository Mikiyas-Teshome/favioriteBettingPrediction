import 'package:dio/dio.dart';
import 'package:faviorite_app/view/auth_screens/login_screen.dart';
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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
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
          } else if (state is AuthSignUpSuccess) {
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
                    child: ConfirmEmailScreen(
                      email: _emailController.text,
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
                      height: 30.0,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "SIGN UP",
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
                            hintText: "First Name",
                            borderRadius: 200.0,
                            borderColor: primaryColor,
                            controller: _firstNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'First Name is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomRoundedTextFormField(
                            hintText: "Last Name",
                            borderRadius: 200.0,
                            borderColor: primaryColor,
                            controller: _lastNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Last Name is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
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
                            text: "Sign Up",
                            isLoading: state is AuthLoading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final email = _emailController.text;
                                final password = _passwordController.text;
                                BlocProvider.of<AuthBloc>(context).add(
                                  SignUpEvent(
                                      email: email,
                                      password: password,
                                      firstname: _firstNameController.text,
                                      lastname: _lastNameController.text),
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
                          "Already have account? ",
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
                                    child: LoginScreen(),
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text(
                            "Sign In",
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
                            Navigator.pushNamed(context, '/home');
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

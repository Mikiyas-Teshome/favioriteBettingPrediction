import 'package:dio/dio.dart';
import 'package:faviorite_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:faviorite_app/bloc/auth_bloc/auth_event.dart';
import 'package:faviorite_app/constants/color_constants.dart';
import 'package:faviorite_app/view/auth_screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/auth_bloc/auth_state.dart';
import '../../services/auth_services/auth_service.dart';
import '../widgets/custom_rounded_button.dart';

class ConfirmEmailScreen extends StatefulWidget {
  final String email;
  final bool isResetPass;
  const ConfirmEmailScreen(
      {super.key, required this.email, this.isResetPass = false});

  @override
  State<ConfirmEmailScreen> createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final AuthService authService = AuthService(Dio(), FlutterSecureStorage());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        } else if (state is AuthEmailResendSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("We have sent an email containing OTP for u!")),
          );
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return BlocProvider(
          //         create: (context) =>
          //             AuthBloc(authService, navigatorKey: navigatorKey),
          //         child: HomeScreen(),
          //       );
          //     },
          //   ),
          // );
        }
      }, builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.09,
                horizontal: MediaQuery.of(context).size.width * 0.075,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    SvgPicture.asset(
                      'assets/confirmIcon.svg',
                      semanticsLabel: 'SVG Image',
                      placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      "CONFIRM YOUR EMAIL",
                      style: TextStyle(
                        fontFamily: "PilatExtended",
                        fontSize: 17.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      "We just sent an email to",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      widget.email,
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomRoundedButton(
                            text: "Confirm",
                            isLoading: state is AuthLoading,
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BlocProvider(
                                      create: (context) => AuthBloc(authService,
                                          navigatorKey: navigatorKey),
                                      child: OtpVerificationScreen(
                                        email: widget.email,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "I ",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<AuthBloc>(context).add(
                              EmailResendEvent(
                                email: widget.email,
                              ),
                            );
                          },
                          child: const Text(
                            "didn't receive ",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 17,
                                color: primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Text(
                          "my email",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

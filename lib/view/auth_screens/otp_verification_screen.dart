import 'package:dio/dio.dart';
import 'package:faviorite_app/view/auth_screens/otp_verified_screen.dart';
import 'package:faviorite_app/view/auth_screens/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/auth_bloc/auth_event.dart';
import '../../bloc/auth_bloc/auth_state.dart';
import '../../constants/color_constants.dart';
import '../../services/auth_services/auth_service.dart';
import '../widgets/custom_rounded_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final bool isPassReset;
  const OtpVerificationScreen(
      {super.key, required this.email, this.isPassReset = false});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final AuthService authService = AuthService(Dio(), FlutterSecureStorage());

  String otpTxt = "";
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
        } else if (state is AuthOtpVerificationSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BlocProvider(
                  create: (context) =>
                      AuthBloc(authService, navigatorKey: navigatorKey),
                  child: OtpVerifiedScreen(
                    isPassReset: false,
                  ),
                );
              },
            ),
          );
        } else if (state is AuthResetPassOtpVerificationSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BlocProvider(
                  create: (context) =>
                      AuthBloc(authService, navigatorKey: navigatorKey),
                  child: ResetPassword(
                    email: widget.email,
                  ),
                );
              },
            ),
          );
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
                      'assets/otpIcon.svg',
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
                      "ENTER VERIFICATION CODE",
                      style: TextStyle(
                        fontFamily: "PilatExtended",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    PinCodeTextField(
                      length: 5,
                      appContext: context,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      cursorColor: primaryColor,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(16),
                        inactiveColor: Color(0xffFFF1E1),
                        inactiveFillColor: Color(0xfffcc690),
                        selectedFillColor: Color(0xffFFF1E1),
                        selectedColor: Color(0xffFFF1E1),
                        activeBoxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        fieldHeight: 53,
                        fieldWidth: 50,
                        activeFillColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.black26
                                : Colors.white12,
                        activeColor: primaryColor,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      controller: _otpController,
                      onCompleted: (v) {
                        FocusManager.instance.primaryFocus?.unfocus();

                        setState(() {
                          otpTxt = v;
                        });

                        if (widget.isPassReset) {
                          BlocProvider.of<AuthBloc>(context).add(
                            ResetPassOtpVerifyEvent(
                                email: widget.email, otp: v),
                          );
                        } else {
                          BlocProvider.of<AuthBloc>(context).add(
                            OtpVerifyEvent(email: widget.email, otp: v),
                          );
                        }
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                      textStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn’t get an email? ",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (widget.isPassReset) {
                              BlocProvider.of<AuthBloc>(context).add(
                                PassResetEmailSendEvent(
                                  email: widget.email,
                                ),
                              );
                            } else {
                              BlocProvider.of<AuthBloc>(context).add(
                                EmailResendEvent(
                                  email: widget.email,
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Send Again ",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 17,
                                color: primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomRoundedButton(
                            text: "Continue",
                            isLoading: state is AuthLoading,
                            onPressed: () {
                              if (widget.isPassReset) {
                                BlocProvider.of<AuthBloc>(context).add(
                                  OtpVerifyEvent(
                                      email: widget.email, otp: otpTxt),
                                );
                              } else {
                                BlocProvider.of<AuthBloc>(context).add(
                                  ResetPassOtpVerifyEvent(
                                      email: widget.email, otp: otpTxt),
                                );
                              }
                            },
                          ),
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

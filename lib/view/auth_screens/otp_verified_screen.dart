import 'package:dio/dio.dart';
import 'package:faviorite_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:faviorite_app/bloc/auth_bloc/auth_event.dart';
import 'package:faviorite_app/constants/color_constants.dart';
import 'package:faviorite_app/view/auth_screens/login_screen.dart';
import 'package:faviorite_app/view/auth_screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/auth_bloc/auth_state.dart';
import '../../services/auth_services/auth_service.dart';
import '../widgets/custom_rounded_button.dart';

class OtpVerifiedScreen extends StatefulWidget {
  final bool isPassReset;

  const OtpVerifiedScreen({super.key, this.isPassReset = false});
  @override
  State<OtpVerifiedScreen> createState() => _OtpVerifiedScreenState();
}

class _OtpVerifiedScreenState extends State<OtpVerifiedScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final AuthService authService = AuthService(Dio(), FlutterSecureStorage());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    height: 40.0,
                  ),
                  SvgPicture.asset(
                    'assets/verifiedIcon.svg',
                    semanticsLabel: 'SVG Image',
                    placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Congratulations!".toUpperCase(),
                    style: const TextStyle(
                      fontFamily: "PilatExtended",
                      fontSize: 17.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    widget.isPassReset
                        ? "You have successfully changed u\’r Account Password, Now Sign In to continue."
                        : "You have successfully verified u\’r Account, Now Sign In to continue.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomRoundedButton(
                          text: "Continue",
                          isLoading: false,
                          onPressed: () {
                            Navigator.pushReplacement(
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

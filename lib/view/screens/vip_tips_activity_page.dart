import 'package:dio/dio.dart';
import 'package:faviorite_app/constants/color_constants.dart';
import 'package:faviorite_app/view/auth_screens/sign_up_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../icons/tips_activity_logo_icons.dart';
import '../../services/auth_services/auth_service.dart';
import '../auth_screens/login_screen.dart';

class VipTipsActivityPage extends StatefulWidget {
  const VipTipsActivityPage({super.key});

  @override
  State<VipTipsActivityPage> createState() => _VipTipsActivityPageState();
}

class _VipTipsActivityPageState extends State<VipTipsActivityPage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final AuthService authService =
      AuthService(Dio(), const FlutterSecureStorage());
  String? userName;
  String? userId;
  int activeSubCat = 0;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  Future<void> _fetchData() async {
    String? launchStatus = await _secureStorage.read(key: 'isFirstLaunch');
    if (launchStatus == null || launchStatus == "true") {
      await _secureStorage.write(key: 'isFirstLaunch', value: "false");
    }

    authService.getUserData().then((userData) {
      if (userData != null) {
        Map<String, String> data = _convertToMapStringString(userData);

        setState(() {
          userName = data['name']!;
          userId = data['uuid'];
        });
      }
    });
  }

  Map<String, String> _convertToMapStringString(Map<String, dynamic>? data) {
    if (data != null) {
      return data.cast<String, String>();
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color(0xff424242)
                          : const Color(0xffd3d3d3),
                      size: 28.0,
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  const Expanded(
                    child: Text(
                      "VIP Subscription",
                      maxLines: 2, // Set the maximum number of lines
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "PilatExtended",
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Icon(
                    TipsActivityLogo.tipsactivitylogo,
                    color: Theme.of(context).brightness == Brightness.light
                        ? const Color(0xff424242)
                        : const Color(0xffd3d3d3),
                    size: 30.0,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor, // Border color
                  width: 1.0, // Border width
                ),
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xffffffff)
                    : const Color(0xff2C2C2C),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color
                    spreadRadius: 3, // Spread radius
                    blurRadius: 7, // Blur radius
                    offset: const Offset(0, 3), // Offset in X and Y direction
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Text(
                    "All in one VIP",
                    maxLines: 2, // Set the maximum number of lines
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "PilatExtended",
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "All VIP Tips & Ad free experience for \nOne Month ",
                    maxLines: 2, // Set the maximum number of lines
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: primaryColor, // Custom color
                    thickness: 1, // Custom thickness
                    indent: 20, // Custom indentation
                    endIndent: 20, // Custom end indentation
                  ),
                  Text(
                    "29.50 USD",
                    maxLines: 2, // Set the maximum number of lines
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "PilatExtended",
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor, // Border color
                  width: 1.0, // Border width
                ),
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xffffffff)
                    : const Color(0xff2C2C2C),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color
                    spreadRadius: 3, // Spread radius
                    blurRadius: 7, // Blur radius
                    offset: const Offset(0, 3), // Offset in X and Y direction
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Text(
                    "All in one VIP",
                    maxLines: 2, // Set the maximum number of lines
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "PilatExtended",
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "All VIP Tips & Ad free experience for \nThree Month ",
                    maxLines: 2, // Set the maximum number of lines
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: primaryColor, // Custom color
                    thickness: 1, // Custom thickness
                    indent: 20, // Custom indentation
                    endIndent: 20, // Custom end indentation
                  ),
                  Text(
                    "77.50 USD",
                    maxLines: 2, // Set the maximum number of lines
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "PilatExtended",
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor, // Border color
                  width: 1.0, // Border width
                ),
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xffffffff)
                    : const Color(0xff2C2C2C),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color
                    spreadRadius: 3, // Spread radius
                    blurRadius: 7, // Blur radius
                    offset: const Offset(0, 3), // Offset in X and Y direction
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Text(
                    "All in one VIP",
                    maxLines: 2, // Set the maximum number of lines
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "PilatExtended",
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "All VIP Tips & Ad free experience for \nSix Month ",
                    maxLines: 2, // Set the maximum number of lines
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: primaryColor, // Custom color
                    thickness: 1, // Custom thickness
                    indent: 20, // Custom indentation
                    endIndent: 20, // Custom end indentation
                  ),
                  Text(
                    "165.50 USD",
                    maxLines: 2, // Set the maximum number of lines
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "PilatExtended",
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            userName == null
                ? const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                      child: Text(
                        "Note:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  )
                : Container(),
            userName == null
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      right: 20.0,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: "To subscribe you must have to ",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign Up ',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 17.5,
                              color: primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BlocProvider(
                                        create: (context) => AuthBloc(
                                            authService,
                                            navigatorKey: navigatorKey),
                                        child: const SignUpScreen(),
                                      );
                                    },
                                  ),
                                );
                              },
                          ),
                          const TextSpan(
                            text: 'or ',
                          ),
                          TextSpan(
                            text: 'Log In',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 17.5,
                              color: primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BlocProvider(
                                        create: (context) => AuthBloc(
                                            authService,
                                            navigatorKey: navigatorKey),
                                        child: const LoginScreen(),
                                      );
                                    },
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

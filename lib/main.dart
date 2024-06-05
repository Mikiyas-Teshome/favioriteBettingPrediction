import 'package:faviorite_app/services/auth_services/auth_service.dart';
import 'package:faviorite_app/view/auth_screens/confirm_email_screen.dart';
import 'package:faviorite_app/view/auth_screens/login_screen.dart';
import 'package:faviorite_app/view/auth_screens/sign_up_screen.dart';
import 'package:faviorite_app/view/screens/landing_page_screen.dart';
import 'package:faviorite_app/view/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'bloc/auth_bloc/auth_bloc.dart';
import 'view/auth_screens/otp_verification_screen.dart';

void main() {
  final Dio dio = Dio(); // You can configure Dio instance here if needed
  final storage = FlutterSecureStorage();
  final AuthService authService = AuthService(dio, storage);

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp(authService: authService));
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  MyApp({required this.authService});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: {
        '/home': (context) => LandingPageScreen(),

        // auth routes ............
        '/sign_up': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        // '/otp_verification': (context) => OtpVerificationScreen(),
        // '/confirmEmail': (context) => ConfirmEmailScreen(),
      },
      home: BlocProvider(
        create: (context) => AuthBloc(authService, navigatorKey: navigatorKey),
        child: LoginScreen(),
      ),
    );
  }
}

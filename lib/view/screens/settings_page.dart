import 'package:dio/dio.dart';
import 'package:faviorite_app/constants/color_constants.dart';
import 'package:faviorite_app/view/screens/contact_us.dart';
import 'package:faviorite_app/view/screens/subscriptions_screen.dart';
import 'package:faviorite_app/view/widgets/settings_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/services.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../services/auth_services/auth_service.dart';
import '../auth_screens/login_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String userName = "Guest";
  String userId = "";
  final AuthService authService =
      AuthService(Dio(), const FlutterSecureStorage());
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: userId)).then((_) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('ID Copied to clipboard')),
      // );
    });
  }

  Map<String, String> _convertToMapStringString(Map<String, dynamic>? data) {
    if (data != null) {
      return data.cast<String, String>();
    } else {
      return {};
    }
  }

  Future<void> _fetchData() async {
    authService.getUserData().then((userData) {
      if (userData != null) {
        Map<String, String> data = _convertToMapStringString(userData);

        setState(() {
          userName = data['name']!;
          userId = data['uuid']!;
        });
      }
    });
  }

  String toPascalCase(String input) {
    return input.split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 20, right: 20.0, left: 20.0, bottom: 20.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Settings',
                  style: TextStyle(
                      fontFamily: "PilatExtended",
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Image.asset(
                "assets/logoIcon.png",
                width: 65.0,
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).brightness == Brightness.light
                ? const Color(0xffF7F7F7)
                : const Color(0xff282828),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15.0,
          ),
          margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                margin: const EdgeInsets.only(
                  right: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: primaryColor,
                ),
                child: Center(
                  child: Text(
                    userName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      toPascalCase(userName),
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    userId != ""
                        ? Row(
                            children: [
                              Expanded(
                                child: Text(
                                  toPascalCase(userId),
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    _copyToClipboard(context);
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                    color: primaryColor,
                                  ))
                            ],
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).brightness == Brightness.light
                ? const Color(0xffF7F7F7)
                : const Color(0xff282828),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          child: Column(
            children: [
              userId == ""
                  ? SettingsMenuItem(
                      menuTitle: "Sign In",
                      menuIcon: Icons.login,
                      isDividerVisible: true,
                      onPressed: () {
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
                      })
                  : Container(),
              userId != ""
                  ? SettingsMenuItem(
                      menuTitle: "Subscription",
                      menuIcon: Icons.credit_card,
                      isDividerVisible: true,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SubscriptionsScreen(
                                userId: userId,
                              );
                            },
                          ),
                        );
                      })
                  : Container(),
              SettingsMenuItem(
                  menuTitle: "Contact Us",
                  menuIcon: Icons.perm_phone_msg_sharp,
                  isDividerVisible: true,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ContactUs();
                        },
                      ),
                    );
                  }),
              SettingsMenuItem(
                  menuTitle: "Rate Us",
                  menuIcon: Icons.star_rate_outlined,
                  isDividerVisible: userId == "" ? false : true,
                  onPressed: () {
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
                  }),
              userId != ""
                  ? SettingsMenuItem(
                      menuTitle: "Log Out",
                      menuIcon: Icons.logout,
                      isDividerVisible: false,
                      onPressed: () {
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
                      })
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}

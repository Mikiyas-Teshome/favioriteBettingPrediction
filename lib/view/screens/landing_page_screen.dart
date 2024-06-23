import 'dart:math';

import 'package:dio/dio.dart';
import 'package:faviorite_app/bloc/bonus_tips_bloc/bonus_tips_bloc.dart';
import 'package:faviorite_app/bloc/tips_bloc/tips_bloc.dart';
import 'package:faviorite_app/constants/color_constants.dart';
import 'package:faviorite_app/cubits/tips_cubit/tips_cubit.dart';
import 'package:faviorite_app/services/bonus_tips_service.dart';
import 'package:faviorite_app/view/screens/free_tips_page.dart';
import 'package:faviorite_app/view/screens/home_page.dart';
import 'package:faviorite_app/view/screens/settings_page.dart';
import 'package:faviorite_app/view/screens/vip_tips_page.dart';
import 'package:faviorite_app/view/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../cubits/free_tips_categories_cubit/free_tips_category_cubit.dart';
import '../../cubits/vip_tips_categories_cubit/vip_tips_category_cubit.dart';
import '../../repositories/category_repository.dart';
import '../../services/auth_services/auth_service.dart';
import '../../services/tips_service.dart';

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.stars_outlined),
    label: 'Free Tips',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.emoji_events),
    label: 'VIP Tips',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings),
    label: 'Settings',
  ),
];

const List<Widget> bottomNavScreen = <Widget>[
  Text('Index 0: Home'),
  Text('Index 1: Category'),
  Text('Index 2: Search'),
  Text('Index 3: Favourite'),
];

class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({super.key});

  @override
  State<LandingPageScreen> createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  final categoryRepository = CategoryRepository();

  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    randomNumbers = generateRandomNumbers();
  }

  late List<int> randomNumbers;
  final List<Widget> _pages = [
    // HomePage(randomNumbers: randomNumbers),
    FreeTipsPage(),
    VIPTipsPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<int> generateRandomNumbers() {
    final random = Random();
    final List<int> numbers = List.generate(7, (index) => index);
    numbers.shuffle(random);
    return numbers.take(6).toList();
  }

  List<String> specialTipsEndPoint = [
    "Over-Under",
    "Basketball",
    "Tennis",
    "Fixed VIP",
    "Daily 10+ Odds VIP",
    "HT-FT VIP",
    "Single VIP + Double VIP",
  ];
  @override
  Widget build(BuildContext context) {
    final categoryRepository = CategoryRepository();

    final bonusTipsService = BonusTipsService();
    // return BlocConsumer<NavBloc, NavState>(
    //   listener: (context, state) {},
    //   builder: (context, state) {
    return MultiBlocProvider(
      // create: (context) =>
      //     ),
      providers: [
        BlocProvider(
          create: (context) => BonusTipsBloc(bonusTipsService)
            ..add(FetchBonusTipsList(categoryName: "Tennis")),
        ),
        BlocProvider(
          create: (context) => FreeTipsCategoryCubit(categoryRepository),
        ),
        BlocProvider(
          create: (context) => VipTipsCategoryCubit(categoryRepository),
        ),
        BlocProvider(
          create: (context) => TipsCubit(categoryRepository),
        ),
      ],
      child: Scaffold(
          body: SafeArea(
              child: _selectedIndex == 0
                  ? BlocProvider(
                      create: (context) {
                        print("Creating BonusTipsBloc"); // Debug print
                        final bloc = BonusTipsBloc(BonusTipsService());
                        bloc.add(FetchBonusTipsList(categoryName: "Tennis"));
                        return bloc;
                      },
                      child: HomePage(randomNumbers: randomNumbers),
                    )
                  : _pages[_selectedIndex - 1]),
          // Center(child: bottomNavScreen.elementAt(state.tabIndex)),
          bottomNavigationBar: Container(
              margin: EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 15,
              ),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color(0xff3F3D3D)
                    : Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color(0xff3F3D3D).withOpacity(0.2)
                        : Colors.grey.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType
                      .fixed, // This ensures the color change applies
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Color(0xff3F3D3D)
                          : Colors.black,
                  items: bottomNavItems,
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    // BlocProvider.of<NavBloc>(context)
                    //     .add(NavTabChange(tabIndex: index));

                    _onItemTapped(index);
                  },
                ),
              ))),
    );
    //   },
    // );
  }

  Map<String, String> _convertToMapStringString(Map<String, dynamic>? data) {
    return data?.cast<String, String>() ?? {};
  }
}

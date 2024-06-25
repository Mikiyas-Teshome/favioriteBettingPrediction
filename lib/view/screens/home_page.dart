import 'dart:math';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:faviorite_app/constants/color_constants.dart';
import 'package:faviorite_app/cubits/bonus_tips_cubit/bonus_tips_cubit.dart';
import 'package:faviorite_app/cubits/tips_cubit/tips_cubit.dart';
import 'package:faviorite_app/view/screens/free_tips_screen.dart';
import 'package:faviorite_app/view/screens/vip_tips_screen.dart';
import 'package:faviorite_app/view/widgets/banner_widget.dart';
import 'package:faviorite_app/view/widgets/collapsible_widget.dart';
import 'package:faviorite_app/view/widgets/match_item_widget.dart';
import 'package:faviorite_app/view/widgets/tip_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../cubits/free_tips_categories_cubit/free_tips_category_cubit.dart';
import '../../cubits/vip_tips_categories_cubit/vip_tips_category_cubit.dart';
import '../../repositories/ad_manager.dart';
import '../../repositories/category_repository.dart';
import '../../repositories/security.dart';
import '../../services/auth_services/auth_service.dart';
import '../../services/bonus_tips_service.dart';
import '../../services/tips_service.dart';
import '../widgets/shimmer_loading.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.randomNumbers});

  final List<int> randomNumbers;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AdManager _adManager = AdManager();
  final AuthService authService =
      AuthService(Dio(), const FlutterSecureStorage());
  String userName = "Guest";
  int activeSubCat = 0;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();

    _adManager.loadInterstitialAd();
    _fetchData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("randomNumgers ${widget.randomNumbers.first}");

      final bonusTipsCubit = context.read<BonusTipsCubit>();
      bonusTipsCubit
          .fetchBonusTipsList(specialTipsEndPoint[widget.randomNumbers.first]);
      // BlocProvider.of<BonusTipsBloc>(context).add(
      //   BonusTipsList(
      //       categoryName: specialTipsEndPoint[widget.randomNumbers.first]),
      // );
    });
  }

  List<String> specialTipsNames = [
    "Over-Under👑",
    "Basketball👑",
    "Tennis👑",
    "Fixed Tips👑",
    "Daily 10+👑",
    "HT-FT 👑",
    "Football Tips👑",
  ];

  List<String> specialTipsIcons = [
    "assets/over_under.png",
    "assets/basketball.png",
    "assets/tennis.png",
    "assets/fixed.png",
    "assets/top_daily_tips.png",
    "assets/halfTime.png",
    "assets/football.png",
  ];

  List<String> specialTipsEndPoint = [
    "Over-Under",
    "Basketball",
    "Tennis",
    "Fixed VIP",
    "Daily 10+ Odds VIP",
    "HT-FT VIP",
    "Football Combine",
  ];

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
        });
      }
    });
  }

  List<String> bannerIcon = [
    "assets/freeCatIcon.png",
    "assets/bonusCatIcon.png",
    "assets/vipCatIcon.png",
  ];
  List<String> bannerText = [
    "Free Tips",
    "Bonus Tips👑",
    "vip Tips",
  ];
  List<String> bannerImage = [
    "assets/freeCatImg.png",
    "assets/bonusCatImg.png",
    "assets/vipCatImg.png",
  ];
  List<Color> bannerColor = [
    const Color(0xffe58411),
    const Color(0xff3A3A3A),
    const Color(0xff083170),
  ];
  List<Color> bannerTextColor = [
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    final categoryRepository = CategoryRepository();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 20, right: 20.0, left: 20.0, bottom: 20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hello",
                      style: TextStyle(
                          fontFamily: "PilatExtended",
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      '$userName'.toUpperCase(),
                      style: const TextStyle(
                          fontFamily: "PilatExtended",
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/logoIcon.png",
                width: 65.0,
              ),
            ],
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.21,
            aspectRatio: MediaQuery.of(context).size.height *
                0.21 /
                MediaQuery.of(context).size.width,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            scrollDirection: Axis.horizontal,
          ),
          items: [0, 1, 2].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    if (i == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BlocProvider(
                              create: (context) =>
                                  FreeTipsCategoryCubit(categoryRepository),
                              child: FreeTipsScreen(),
                            );
                          },
                        ),
                      );
                    } else if (i == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BlocProvider(
                              create: (context) =>
                                  VipTipsCategoryCubit(categoryRepository),
                              child: VipTipsScreen(),
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: BannerWidget(
                    bannerIcon: bannerIcon[i],
                    bannerText: bannerText[i],
                    bannerImage: bannerImage[i],
                    bannerColor: bannerColor[i],
                    bannerTextColor: bannerTextColor[i],
                  ),
                );
              },
            );
          }).toList(),
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 20.0,
            bottom: 10.0,
            left: 20.0,
          ),
          child: Text(
            "Picks for You",
            style: TextStyle(
                fontFamily: "PilatExtended",
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          height: 63.0,
          padding: const EdgeInsets.only(
            left: 20.0,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection:
                Axis.horizontal, // Set scroll direction to horizontal
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 5.0),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        activeSubCat = index;
                      });
                      context.read<BonusTipsCubit>().fetchBonusTipsList(
                          specialTipsEndPoint[widget.randomNumbers[index]]);
                      // BlocProvider.of<BonusTipsBloc>(context).add(
                      //   BonusTipsList(
                      //       categoryName: specialTipsEndPoint[
                      //           widget.randomNumbers[index]]),
                      // );
                    },
                    child: CollapsableWidget(
                      isActive: activeSubCat == index ? true : false,
                      title: specialTipsNames[widget.randomNumbers[index]],
                      icon: specialTipsIcons[widget.randomNumbers[index]],
                    )),
              );
            },
          ),
        ),
        BlocBuilder<BonusTipsCubit, BonusTipsState>(
          builder: (context, state) {
            if (state is BonusTipsLoading) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: ListView.builder(
                    shrinkWrap: true, // Set scroll direction to horizontal
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ShimmerLoading(
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 12.0,
                            bottom: 12.0,
                          ),
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color(0xffffffff)
                                    : const Color(0xff2C2C2C),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width * 0.38,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else if (state is BonusTipsSuccess) {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true, // Set scroll direction to horizontal
                  itemCount: state.tips.categoryList.first.couponList.first
                      .matchList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _adManager.showInterstitialAd();
                        if (_adManager.adShowingNotifier.value) {
                        } else {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled:
                                true, // Optional: Set to true if your bottom sheet content might scroll
                            backgroundColor: Colors.black.withOpacity(
                                0.8), // Set semi-transparent background
                            builder: (context) => TipBottomSheet(
                                date:
                                    "${formatDateString(Security.decrypt(state.tips.categoryList.first.couponList.first.matchList[index].date))} ${Security.decrypt(state.tips.categoryList.first.couponList.first.matchList[index].time)}",
                                league: Security.decrypt(state
                                    .tips
                                    .categoryList
                                    .first
                                    .couponList
                                    .first
                                    .matchList[index]
                                    .league),
                                homeTeamName: Security.decrypt(state
                                    .tips
                                    .categoryList
                                    .first
                                    .couponList
                                    .first
                                    .matchList[index]
                                    .home),
                                awayTeamName: Security.decrypt(state
                                    .tips
                                    .categoryList
                                    .first
                                    .couponList
                                    .first
                                    .matchList[index]
                                    .visitor),
                                homeTeamScore:
                                    Security.decrypt(state.tips.categoryList.first.couponList.first.matchList[index].homeScore),
                                awayTeamScore: Security.decrypt(state.tips.categoryList.first.couponList.first.matchList[index].visitorScore),
                                matchTip: Security.decrypt(state.tips.categoryList.first.couponList.first.matchList[index].bet),
                                matchStatus: Security.decrypt(state.tips.categoryList.first.couponList.first.matchList[index].status)),
                          );
                        }
                      },
                      child: MatchItemWidget(
                        matchTime: Security.decrypt(state.tips.categoryList
                            .first.couponList.first.matchList[index].time),
                        leagueName: Security.decrypt(state.tips.categoryList
                            .first.couponList.first.matchList[index].league),
                        homeTeamName: Security.decrypt(state.tips.categoryList
                            .first.couponList.first.matchList[index].home),
                        awayTeamName: Security.decrypt(state.tips.categoryList
                            .first.couponList.first.matchList[index].visitor),
                        homeTeamScore: Security.decrypt(state.tips.categoryList
                            .first.couponList.first.matchList[index].homeScore),
                        awayTeamScore: Security.decrypt(state
                            .tips
                            .categoryList
                            .first
                            .couponList
                            .first
                            .matchList[index]
                            .visitorScore),
                        tipOdd: Security.decrypt(state.tips.categoryList.first
                            .couponList.first.matchList[index].rate),
                        matchStatus: Security.decrypt(state.tips.categoryList
                            .first.couponList.first.matchList[index].status),
                      ),
                    );
                  },
                ),
              );
            } else if (state is BonusTipsErrorState) {
              return Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      context.read<BonusTipsCubit>().fetchBonusTipsList(
                          specialTipsEndPoint[
                              widget.randomNumbers[activeSubCat]]);
                      // BlocProvider.of<BonusTipsBloc>(context).add(
                      //   BonusTipsList(
                      //       categoryName: specialTipsEndPoint[
                      //           widget.randomNumbers[activeSubCat]]),
                      // );
                    },
                    child: const Text(
                      "Network Error! \n No data \n Tap to retry",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
    //   },
    // );
  }

  String formatDateString(String dateString) {
    // Parse the input date string  2024-06-24
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateTime dateTime = inputFormat.parse(dateString);

    // Format the DateTime object to the desired format
    DateFormat outputFormat = DateFormat('EEE dd MMM');
    String formattedDate = outputFormat.format(dateTime);

    return formattedDate;
  }

  Map<String, String> _convertToMapStringString(Map<String, dynamic>? data) {
    if (data != null) {
      return data.cast<String, String>();
    } else {
      return {};
    }
  }
}

import 'dart:math';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:faviorite_app/constants/color_constants.dart';
import 'package:faviorite_app/cubits/tips_cubit/tips_cubit.dart';
import 'package:faviorite_app/view/widgets/banner_widget.dart';
import 'package:faviorite_app/view/widgets/collapsible_widget.dart';
import 'package:faviorite_app/view/widgets/match_item_widget.dart';
import 'package:faviorite_app/view/widgets/tip_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../cubits/categories_cubit/category_cubit.dart';
import '../../repositories/ad_manager.dart';
import '../../services/auth_services/auth_service.dart';
import '../../services/tips_service.dart';
import '../widgets/shimmer_loading.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AdManager _adManager = AdManager();
  final AuthService authService =
      AuthService(Dio(), const FlutterSecureStorage());
  String userName = "Guest";
  int activeSubCat = 0;
  @override
  void initState() {
    super.initState();

    _adManager.loadInterstitialAd();
    _fetchData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryCubit = context.read<CategoryCubit>();
      categoryCubit.fetchCategories().then((_) {
        final categoryState = categoryCubit.state;
        if (categoryState is CategoryLoaded) {
          final firstCategoryId = categoryState
              .categories.data[categoryState.randomNumbers.first].id;
          context.read<TipsCubit>().fetchTips(firstCategoryId);
        }
      });
    });
  }

  Future<void> _fetchData() async {
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
    "Bonus Tips",
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

  List<Widget> subCategories = [];

  @override
  Widget build(BuildContext context) {
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
                return BannerWidget(
                  bannerIcon: bannerIcon[i],
                  bannerText: bannerText[i],
                  bannerImage: bannerImage[i],
                  bannerColor: bannerColor[i],
                  bannerTextColor: bannerTextColor[i],
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
        BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return Container(
                height: 63.0,
                padding: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: ShimmerLoading(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        9, // Adjust count for desired number of shimmer items
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          width: 63.0,
                          height: 63.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color(0xffD6D8DA)
                                    : const Color(0xffB1B1B1),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else if (state is CategoryLoaded) {
              final categories = state.categories.data;
              final randomNumbers = state.randomNumbers;
              return Container(
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
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              activeSubCat = index;
                            });
                            context
                                .read<TipsCubit>()
                                .fetchTips(categories[randomNumbers[index]].id);
                          },
                          child: CollapsableWidget(
                            isActive: activeSubCat == index ? true : false,
                            title: categories[randomNumbers[index]].name,
                            iconUrl:
                                "https://totaltipsbet.com/uploads/${categories[randomNumbers[index]].image}",
                          )),
                    );
                  },
                ),
              );
            } else if (state is CategoryError) {
              return Expanded(
                child: Center(
                  child: Text(
                    "Network Error! No data",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 17,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        BlocBuilder<TipsCubit, TipsState>(
          builder: (context, state) {
            if (state is TipsLoading) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: ListView.builder(
                    shrinkWrap: true, // Set scroll direction to horizontal
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const ShimmerLoading(
                        child: MatchItemWidget(
                          homeTeamName: "homeTeamName",
                          awayTeamName: "awayTeamName",
                          homeTeamLogo:
                              "cdd26aea-d092-4047-b1b5-c53f783c5bba.png",
                          awayTeamLogo:
                              "cdd26aea-d092-4047-b1b5-c53f783c5bba.png",
                          tipOdd: "tipOdd",
                          matchStatus: "matchStatus",
                          leagueName: "leagueName",
                          matchScore: "matchScore",
                          matchTime: "1:1",
                        ),
                      );
                    },
                  ),
                ),
              );
            } else if (state is TipsLoaded) {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true, // Set scroll direction to horizontal
                  itemCount: state.tips.data.length - 1,
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
                                    "${formatDateString(state.tips.data[index + 1].coupon!.date)} ${state.tips.data[index + 1].time!}",
                                league: state.tips.data[index + 1].league!.name,
                                homeTeamName:
                                    state.tips.data[index + 1].teamHome!.name,
                                awayTeamName:
                                    state.tips.data[index + 1].teamAway!.name,
                                homeTeamScore:
                                    state.tips.data[index + 1].homeScore!,
                                awayTeamScore:
                                    state.tips.data[index + 1].awayScore!,
                                matchTip: state.tips.data[index + 1].forecast!,
                                matchStatus:
                                    state.tips.data[index + 1].status!),
                          );
                        }
                      },
                      child: MatchItemWidget(
                        homeTeamName: state.tips.data[index + 1].teamHome!.name,
                        awayTeamName: state.tips.data[index + 1].teamAway!.name,
                        homeTeamLogo:
                            state.tips.data[index + 1].teamHome!.image!,
                        awayTeamLogo:
                            state.tips.data[index + 1].teamAway!.image!,
                        tipOdd: state.tips.data[index + 1].odds!,
                        matchStatus: state.tips.data[index + 1].status!,
                        leagueName: state.tips.data[index + 1].league!.name,
                        matchScore:
                            "${state.tips.data[index + 1].homeScore!} : ${state.tips.data[index + 1].awayScore!}",
                        matchTime: state.tips.data[index + 1].time!,
                      ),
                    );
                  },
                ),
              );
            } else if (state is TipsError) {
              return Expanded(
                child: Center(
                  child: Text(
                    "Network Error! \n No data",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 17,
                        fontWeight: FontWeight.w300),
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
    // Parse the input date string
    DateFormat inputFormat = DateFormat('dd.MM.yyyy');
    DateTime dateTime = inputFormat.parse(dateString);

    // Format the DateTime object to the desired format
    DateFormat outputFormat = DateFormat('EEE dd MMM');
    String formattedDate = outputFormat.format(dateTime);

    return formattedDate;
  }

  List<int> generateRandomNumbers() {
    final random = Random();
    final List<int> numbers = List.generate(10, (index) => index);
    numbers.shuffle(random);
    return numbers.take(6).toList();
  }

  Map<String, String> _convertToMapStringString(Map<String, dynamic>? data) {
    if (data != null) {
      return data.cast<String, String>();
    } else {
      return {};
    }
  }
}

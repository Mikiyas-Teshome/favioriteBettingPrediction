import 'package:faviorite_app/view/widgets/match_tip_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/color_constants.dart';
import '../../cubits/tips_cubit/tips_cubit.dart';
import '../../icons/tips_activity_logo_icons.dart';
import '../widgets/shimmer_loading.dart';

class FreeTipsActivityPage extends StatefulWidget {
  const FreeTipsActivityPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  final String categoryId, categoryName;

  @override
  State<FreeTipsActivityPage> createState() => _FreeTipsActivityPageState();
}

class _FreeTipsActivityPageState extends State<FreeTipsActivityPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tipsCubit = context.read<TipsCubit>();
      tipsCubit.fetchTips(widget.categoryId);
    });
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
                  Expanded(
                    child: Text(
                      widget.categoryName,
                      maxLines: 2, // Set the maximum number of lines
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
                    size: 28.0,
                  ),
                ],
              ),
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
                          return ShimmerLoading(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              width: double.infinity,
                              height: 180,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: primaryColor, // Border color
                                  width: 1.0, // Border width
                                ),
                              ),
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
                        return MatchTipItemWidget(
                          homeTeamName:
                              state.tips.data[index + 1].teamHome!.name,
                          awayTeamName:
                              state.tips.data[index + 1].teamAway!.name,
                          homeTeamLogo:
                              state.tips.data[index + 1].teamHome!.image!,
                          awayTeamLogo:
                              state.tips.data[index + 1].teamAway!.image!,
                          Odd: state.tips.data[index + 1].odds!,
                          matchStatus: state.tips.data[index + 1].status!,
                          leagueName: state.tips.data[index + 1].league!.name,
                          homeTeamScore: state.tips.data[index + 1].homeScore!,
                          awayTeamScore: state.tips.data[index + 1].awayScore!,
                          time: state.tips.data[index + 1].time!,
                          matchTip: state.tips.data[index + 1].forecast!,
                        );
                      },
                    ),
                  );
                } else if (state is TipsError) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        "Network Error! \n No data",
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
        ),
      ),
    );
  }
}

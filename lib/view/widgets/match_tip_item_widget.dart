import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class MatchTipItemWidget extends StatelessWidget {
  const MatchTipItemWidget({
    super.key,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.homeTeamScore,
    required this.awayTeamScore,
    required this.matchStatus,
    required this.matchTip,
    required this.Odd,
    required this.leagueName,
    required this.time,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
  });

  final String homeTeamName,
      awayTeamName,
      homeTeamScore,
      awayTeamScore,
      homeTeamLogo,
      awayTeamLogo,
      matchStatus,
      matchTip,
      Odd,
      leagueName,
      time;

  // IconData matchStatusIcon;
  Icon matchStatusIcon(String matchStatus) {
    if (matchStatus == "NOT_START") {
      return const Icon(
        Icons.alarm,
        color: Color(0xffdcbc1d),
        size: 40,
      );
    } else if (matchStatus == "LOST") {
      return const Icon(
        Icons.cancel,
        color: Colors.red,
        size: 40,
      );
    } else if (matchStatus == "POSTPONED") {
      return const Icon(
        Icons.access_time_filled,
        color: Color(0xffdcbc1d),
        size: 40,
      );
    } else {
      return const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 40,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 12.0,
        bottom: 12.0,
      ),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        // color: Theme.of(context).brightness == Brightness.light
        //     ? const Color(0xffffffff)
        //     : const Color(0xff2C2C2C),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: primaryColor, // Border color
          width: 1.0, // Border width
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Text(
                  leagueName,
                  style: const TextStyle(
                    fontFamily: "PilatExtended",
                    fontSize: 15.2,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.play_circle_outline,
                    color: primaryColor,
                    size: 18.0,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20.0,
                    ),
                    child: Text(
                      time,
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black.withOpacity(0.085)
                                    : Colors.white
                                        .withOpacity(0.5), // Shadow color
                                spreadRadius: 1, // Spread radius
                                blurRadius: 6, // Blur radius
                                offset: const Offset(
                                    0, 1), // Offset in X and Y direction
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/subCatIcon.png',
                                image:
                                    "https://totaltipsbet.com/uploads/$homeTeamLogo",
                                placeholderScale: 1,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.error,
                                    size: 60,
                                  );
                                },
                                fadeInDuration:
                                    const Duration(milliseconds: 300),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            homeTeamName,
                            style: TextStyle(
                                fontFamily: "PilatExtended",
                                fontSize: 15,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black38
                                    : Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          homeTeamScore,
                          style: TextStyle(
                              fontFamily: "PilatExtended",
                              fontSize: 17,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black38
                                  : Colors.white70,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black.withOpacity(0.085)
                                    : Colors.white
                                        .withOpacity(0.5), // Shadow color
                                spreadRadius: 1, // Spread radius
                                blurRadius: 6, // Blur radius
                                offset: const Offset(
                                    0, 1), // Offset in X and Y direction
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/subCatIcon.png',
                                image:
                                    "https://totaltipsbet.com/uploads/$awayTeamLogo",
                                placeholderScale: 1,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.error,
                                    size: 50,
                                  );
                                },
                                fadeInDuration:
                                    const Duration(milliseconds: 300),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            awayTeamName,
                            style: TextStyle(
                                fontFamily: "PilatExtended",
                                fontSize: 15,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black38
                                    : Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          awayTeamScore,
                          style: TextStyle(
                              fontFamily: "PilatExtended",
                              fontSize: 17,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black38
                                  : Colors.white70,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: matchStatusIcon(matchStatus),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor, // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    matchTip,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 15.5,
                        color: primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                  right: 20.0,
                  left: 6.0,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  color: primaryColor,
                  border: Border.all(
                    color: primaryColor, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "ODD: $Odd",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color(0xffffffff)
                          : const Color(0xff2C2C2C),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          // Align(
          //     alignment: Alignment.center,
          //     child: matchStatusIcon(matchStatus)),
        ],
      ),
    );
  }
}

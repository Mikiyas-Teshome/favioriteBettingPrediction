import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class TipBottomSheet extends StatelessWidget {
  const TipBottomSheet(
      {super.key,
      required this.date,
      required this.league,
      required this.homeTeamName,
      required this.awayTeamName,
      required this.homeTeamScore,
      required this.awayTeamScore,
      required this.matchTip,
      required this.matchStatus});

  final String date,
      league,
      homeTeamName,
      awayTeamName,
      homeTeamScore,
      awayTeamScore,
      matchTip,
      matchStatus;

  Icon matchStatusIcon(String matchStatus) {
    if (matchStatus == "NOT_START") {
      return const Icon(
        Icons.alarm,
        color: Colors.yellow,
        size: 44,
      );
    } else if (matchStatus == "LOST") {
      return const Icon(
        Icons.cancel,
        color: Colors.red,
        size: 44,
      );
    } else if (matchStatus == "POSTPONED") {
      return const Icon(
        Icons.access_time_filled,
        color: Colors.yellow,
        size: 44,
      );
    } else {
      return const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 44,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 30.0,
      ),
      height: MediaQuery.of(context).size.height * 0.450,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? const Color(0xffffffff)
            : const Color(0xff2C2C2C),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0), // Adjust the radius value as needed
          topRight: Radius.circular(20.0), // Adjust the radius value as needed
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.094,
                ),
                child: Text(
                  date,
                  style: const TextStyle(
                      fontFamily: "PilatExtended",
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.094,
                ),
                child: Text(
                  league,
                  style: const TextStyle(
                      fontFamily: "PilatExtended",
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.022,
                    height: MediaQuery.of(context).size.width * 0.055,
                    color: primaryColor,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.072,
                  ),
                  Expanded(
                    child: Text(
                      homeTeamName,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black38
                                  : Colors.white70,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    homeTeamScore,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 19,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black38
                            : Colors.white70,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.072,
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.022,
                    height: MediaQuery.of(context).size.width * 0.055,
                    color: primaryColor,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.072,
                  ),
                  Expanded(
                    child: Text(
                      awayTeamName,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black38
                                  : Colors.white70,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    awayTeamScore,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 19,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black38
                            : Colors.white70,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.072,
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor, // Border color
                    width: 1.80, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Expanded(
                  child: Text(
                    matchTip,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: matchStatusIcon(matchStatus)),
            ],
          ),
        ),
      ),
    );
  }
}

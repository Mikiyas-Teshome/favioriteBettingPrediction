import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class MatchItemWidget extends StatelessWidget {
  final String homeTeamName,
      awayTeamName,
      homeTeamScore,
      awayTeamScore,
      tipOdd,
      matchStatus,
      leagueName,
      matchTime;
  const MatchItemWidget({
    super.key,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.homeTeamScore,
    required this.awayTeamScore,
    required this.tipOdd,
    required this.matchStatus,
    required this.leagueName,
    required this.matchTime,
  });

  // IconData matchStatusIcon;
  Icon matchStatusIcon(String matchStatus) {
    if (matchStatus == "NOT_START") {
      return const Icon(
        Icons.alarm,
        color: primaryColor,
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
        color: primaryColor,
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
      margin: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff808080), // Border color
          width: 1.0, // Border width
        ),
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).brightness == Brightness.light
            ? Color(0xffF6F6F6)
            : Color(0xff252525),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.12), // Shadow color
        //     spreadRadius: 3, // Spread radius
        //     blurRadius: 5, // Blur radius
        //     offset: Offset(0, 3), // Offset in X and Y direction
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Text(
                  leagueName,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                width: 7.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.play_circle_outline,
                    color: primaryColor,
                    size: 16.0,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    matchTime,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xff545454)
                            : Color(0xffb9b9b9),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: primaryColor,
            indent: 20.0,
            endIndent: 20.0,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                        top: 10.0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Color(0xff0055D5),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Image.asset(
                            "assets/homeTeam.png",
                            width: 35.0,
                            height: 35.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              homeTeamName,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              homeTeamScore,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                        top: 10.0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Color(0xffA61C20),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Image.asset(
                            "assets/awayTeam.png",
                            width: 35.0,
                            height: 35.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              awayTeamName,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              awayTeamScore,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              matchStatusIcon(matchStatus),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: primaryColor,
            indent: 20.0,
            endIndent: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(
              tipOdd,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 17,
                  // color: primaryColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );

    //   Container(
    //   margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    //   padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
    //   decoration: BoxDecoration(
    //     border: Border.all(
    //       color: Theme.of(context).brightness == Brightness.light
    //           ? Color(0xffE7E7E7)
    //           : Color(0xff5E5E5E), // Border color
    //       width: 1.80, // Border width
    //     ),
    //     borderRadius: BorderRadius.circular(10),
    //     color: Theme.of(context).brightness == Brightness.light
    //         ? Color(0xffffffff)
    //         : Color(0xff2C2C2C),
    //     // boxShadow: [
    //     //   BoxShadow(
    //     //     color: Colors.black.withOpacity(0.1), // Shadow color
    //     //     spreadRadius: 5, // Spread radius
    //     //     blurRadius: 7, // Blur radius
    //     //     offset: Offset(0, 3), // Offset in X and Y direction
    //     //   ),
    //     // ],
    //   ),
    //   child: Column(
    //     children: [
    //       Row(
    //         children: [
    //           Expanded(
    //             child: Text(
    //               leagueName,
    //               style: TextStyle(
    //                   fontFamily: 'Poppins',
    //                   fontSize: 17.0,
    //                   fontWeight: FontWeight.w500),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 7.0,
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               const Icon(
    //                 Icons.play_circle_outline,
    //                 color: primaryColor,
    //                 size: 16.0,
    //               ),
    //               SizedBox(
    //                 width: 10.0,
    //               ),
    //               Text(
    //                 matchTime,
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                     fontFamily: 'Poppins',
    //                     color: Theme.of(context).brightness == Brightness.light
    //                         ? Color(0xff545454)
    //                         : Color(0xffb9b9b9),
    //                     fontSize: 16.0,
    //                     fontWeight: FontWeight.w500),
    //               ),
    //               SizedBox(
    //                 width: 10.0,
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //       SizedBox(
    //         height: 5.0,
    //       ),
    //       Row(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Expanded(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               mainAxisSize: MainAxisSize.max,
    //               children: [
    //                 Container(
    //                   width: 55,
    //                   height: 55,
    //                   decoration: BoxDecoration(
    //                     shape: BoxShape.circle,
    //                     color: Colors.white,
    //                     boxShadow: [
    //                       BoxShadow(
    //                         color: Theme.of(context).brightness ==
    //                                 Brightness.light
    //                             ? Colors.black.withOpacity(0.085)
    //                             : Colors.white.withOpacity(0.5), // Shadow color
    //                         spreadRadius: 1, // Spread radius
    //                         blurRadius: 6, // Blur radius
    //                         offset: Offset(0, 1), // Offset in X and Y direction
    //                       ),
    //                     ],
    //                   ),
    //                   child: ClipOval(
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(5.0),
    //                       child: FadeInImage.assetNetwork(
    //                         placeholder: 'assets/subCatIcon.png',
    //                         image:
    //                             "https://totaltipsbet.com/uploads/$homeTeamLogo",
    //                         placeholderScale: 1,
    //                         imageErrorBuilder: (context, error, stackTrace) {
    //                           return Icon(
    //                             Icons.error,
    //                             size: 50,
    //                           );
    //                         },
    //                         fadeInDuration: Duration(milliseconds: 300),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 7.0,
    //                 ),
    //                 Text(
    //                   homeTeamName,
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                       fontFamily: 'Poppins',
    //                       fontSize: 17.0,
    //                       fontWeight: FontWeight.w500),
    //                 ),
    //                 SizedBox(
    //                   height: 7.0,
    //                 ),
    //                 Container(
    //                   padding: EdgeInsets.all(10.0),
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(8),
    //                     color: Theme.of(context).brightness == Brightness.light
    //                         ? Color(0xffF3F4F5)
    //                         : Color(0xff4d4b4b),
    //                   ),
    //                   child: Text(
    //                     "ODD: $tipOdd",
    //                     textAlign: TextAlign.center,
    //                     style: TextStyle(
    //                         fontFamily: 'Poppins',
    //                         fontSize: 17.0,
    //                         fontWeight: FontWeight.w500),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //           Expanded(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   matchScore,
    //                   style: TextStyle(
    //                       fontFamily: "Poppins",
    //                       fontSize: 23,
    //                       fontWeight: FontWeight.w800),
    //                 ),
    //                 SizedBox(
    //                   height: 7.0,
    //                 ),
    //                 matchStatusIcon(matchStatus),
    //               ],
    //             ),
    //           ),
    //           Expanded(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Container(
    //                   width: 55,
    //                   height: 55,
    //                   decoration: BoxDecoration(
    //                     shape: BoxShape.circle,
    //                     color: Colors.white,
    //                     boxShadow: [
    //                       BoxShadow(
    //                         color:
    //                             Theme.of(context).brightness == Brightness.light
    //                                 ? Colors.black.withOpacity(0.085)
    //                                 : Colors.white.withOpacity(0.5),
    //                         spreadRadius: 1, // Spread radius
    //                         blurRadius: 6, // Blur radius
    //                         offset: Offset(0, 1), // Offset in X and Y direction
    //                       ),
    //                     ],
    //                   ),
    //                   child: ClipOval(
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(5.0),
    //                       child: FadeInImage.assetNetwork(
    //                         placeholder: 'assets/subCatIcon.png',
    //                         image:
    //                             "https://totaltipsbet.com/uploads/$awayTeamLogo",
    //                         placeholderScale: 1,
    //                         imageErrorBuilder: (context, error, stackTrace) {
    //                           return Icon(
    //                             Icons.error,
    //                             size: 50,
    //                           );
    //                         },
    //                         fadeInDuration: Duration(milliseconds: 300),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 7.0,
    //                 ),
    //                 Text(
    //                   awayTeamName,
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                       fontFamily: 'Poppins',
    //                       fontSize: 17.0,
    //                       fontWeight: FontWeight.w500),
    //                 ),
    //                 SizedBox(
    //                   height: 7.0,
    //                 ),
    //                 Container(
    //                   padding:
    //                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(8),
    //                     color: Theme.of(context).brightness == Brightness.light
    //                         ? Color(0xffF3F4F5)
    //                         : Color(0xff4d4b4b),
    //                   ),
    //                   child: Icon(
    //                     Icons.visibility,
    //                   ),
    //                 )
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}

import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import '../../icons/tips_activity_logo_icons.dart';

class FreeTipsAtivityPage extends StatefulWidget {
  const FreeTipsAtivityPage({super.key});

  @override
  State<FreeTipsAtivityPage> createState() => _FreeTipsAtivityPageState();
}

class _FreeTipsAtivityPageState extends State<FreeTipsAtivityPage> {
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
                      "Freee is Tips Acc Free is Tips Acc",
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
                    size: 28.0,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 18.0,
              ),
              width: MediaQuery.of(context).size.width,
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xffffffff)
                    : const Color(0xff2C2C2C),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                    ),
                    child: Text(
                      "league",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
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
                                  "https://totaltipsbet.com/uploads/cdd26aea-d092-4047-b1b5-c53f783c5bba.png",
                              placeholderScale: 1,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.error,
                                  size: 50,
                                );
                              },
                              fadeInDuration: const Duration(milliseconds: 300),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "homeTeamName",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black38
                                  : Colors.white70,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        "0",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 19,
                            color:
                                Theme.of(context).brightness == Brightness.light
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
                        width: 35,
                        height: 35,
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
                                  "https://totaltipsbet.com/uploads/cdd26aea-d092-4047-b1b5-c53f783c5bba.png",
                              placeholderScale: 1,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.error,
                                  size: 50,
                                );
                              },
                              fadeInDuration: const Duration(milliseconds: 300),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "awayTeamName",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black38
                                  : Colors.white70,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        "0",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 19,
                            color:
                                Theme.of(context).brightness == Brightness.light
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
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 20.0),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: primaryColor, // Border color
                              width: 1.80, // Border width
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Expanded(
                            child: Text(
                              "ODD: 1.5",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  // Align(
                  //     alignment: Alignment.center,
                  //     child: matchStatusIcon(matchStatus)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

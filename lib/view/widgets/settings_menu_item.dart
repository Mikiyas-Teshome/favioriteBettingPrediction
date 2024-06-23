import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class SettingsMenuItem extends StatelessWidget {
  const SettingsMenuItem(
      {super.key,
      required this.menuTitle,
      required this.menuIcon,
      required this.isDividerVisible,
      required this.onPressed});

  final String menuTitle;
  final IconData menuIcon;
  final bool isDividerVisible;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 9.0,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              menuIcon,
              color: primaryColor,
              size: 24.0,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Text(
                          menuTitle,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 9.0,
                  ),
                  isDividerVisible
                      ? Divider(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xffD4D4D4)
                                  : const Color(0xff515151),
                          thickness: 1.1, // Change the thickness
                          indent: 10, // Indent from the start
                          endIndent: 10,
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

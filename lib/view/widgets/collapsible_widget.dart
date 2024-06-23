import 'package:flutter/material.dart';

class CollapsableWidget extends StatelessWidget {
  const CollapsableWidget(
      {super.key,
      required this.isActive,
      required this.title,
      required this.icon});

  final bool isActive;
  final String title;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isActive
            ? (Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white)
            : (Theme.of(context).brightness == Brightness.light
                ? Color(0xffD6D8DA)
                : Color(0xffB1B1B1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipOval(
                child: Image.asset(
              icon,
            )),
          ),
          isActive
              ? Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

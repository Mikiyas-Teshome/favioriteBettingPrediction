import 'package:faviorite_app/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String image;
  final Color strokeColor;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomIconButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.image,
    this.strokeColor = primaryColor,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          border: Border.all(color: strokeColor, width: 2),
          color: backgroundColor),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ??
              (Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black),
          elevation: 0, // Remove elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(200),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 3,
                top: 5.0,
                bottom: 5.0,
              ),
              child: Image.asset(
                image,
                width: 38,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: textColor ??
                        (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)),
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}

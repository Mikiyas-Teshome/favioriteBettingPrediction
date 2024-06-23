import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/color_constants.dart';

class ContactUsItems extends StatelessWidget {
  const ContactUsItems(
      {super.key,
      required this.linkTxt,
      required this.icon,
      required this.url,
      this.isPhone = false,
      required this.phoneText});

  final String linkTxt, icon;
  final Uri url;
  final bool isPhone;
  final Widget phoneText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            icon,
            width: 30,
            height: 30,
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: isPhone
                ? phoneText
                : GestureDetector(
                    onTap: () {
                      _launchURL(
                        url,
                      );
                    },
                    child: Text(
                      linkTxt,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                        color: primaryColor,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void _launchURL(Uri url) async {
    // final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

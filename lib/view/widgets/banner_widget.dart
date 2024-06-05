import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.bannerIcon,
    required this.bannerText,
    required this.bannerImage,
    required this.bannerColor,
    required this.bannerTextColor,
    this.bannerImageFit = BoxFit.fitHeight,
  });

  final String bannerIcon;
  final BoxFit bannerImageFit;
  final String bannerText;
  final String bannerImage;
  final Color bannerColor;
  final Color bannerTextColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.23,
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.only(
          right: 15,
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: bannerColor,
                image: DecorationImage(
                    image:
                        AssetImage(bannerIcon), // Replace with your image path
                    fit:
                        bannerImageFit, // Adjust how the image fits within the container
                    alignment: Alignment.centerLeft),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 40.0),
                    child: Text(bannerText.toUpperCase(),
                        style: TextStyle(
                            fontFamily: "PilatExtended",
                            fontSize: 19,
                            color: bannerTextColor,
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center),
                  ),
                ),
                Image(
                    height: MediaQuery.of(context).size.height * 0.21,
                    image: AssetImage(
                      bannerImage,
                    ))
              ],
            ),
          ],
        ));
  }
}

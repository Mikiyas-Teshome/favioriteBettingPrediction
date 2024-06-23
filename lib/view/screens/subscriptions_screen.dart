import 'package:faviorite_app/constants/color_constants.dart';
import 'package:faviorite_app/view/widgets/contact_us_items.dart';
import 'package:faviorite_app/view/widgets/payment_method_item.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../icons/tips_activity_logo_icons.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key, required this.userId});

  final String userId;
  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  List<String> paymentMethodIcons = [
    "assets/card.png",
    "assets/payoneerLogo.png",
    "assets/binanceLogo.png"
  ];

  List<String> paymentMethodName = [
    "Bank Card",
    "Payoneer",
    "Crypto",
  ];

  List<String> paymentMethodDes = [
    "Mastercard or Visa",
    "Direct Transfer",
    "USDT",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    const Expanded(
                      child: Text(
                        "Buy Subscription",
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
                      size: 30.0,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, bottom: 20),
                child: Text(
                  "Payment Methods",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins"),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                ),
                height: 170,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      3, // Adjust count for desired number of shimmer items
                  itemBuilder: (context, index) {
                    return PaymentMethodItem(
                      icon: paymentMethodIcons[index],
                      name: paymentMethodName[index],
                      des: paymentMethodDes[index],
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Text(
                  "Your ID",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins"),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black12
                        : const Color(0xffB0B0B0), // Stroke color
                    width: 1, // Stroke width
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.userId,
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff747474),
                            fontFamily: "Poppins"),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          _copyToClipboard(context, widget.userId);
                        },
                        icon: const Icon(
                          Icons.copy,
                          color: primaryColor,
                        ))
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 10),
                child: Text(
                  "Contact Us with your ID",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins"),
                ),
              ),
              ContactUsItems(
                linkTxt: "https://t.me/bekurAppSupport",
                icon: "assets/telegramIcon.png",
                url: Uri.parse(
                  "https://t.me/bekurAppSupport",
                ),
                phoneText: Container(),
              ),
              ContactUsItems(
                linkTxt: "WhatsApp: +251 712 03 18 03",
                icon: "assets/whatsapp.png",
                url: Uri.parse("https://wa.me/251712031803"),
                phoneText: Container(),
              ),
              ContactUsItems(
                linkTxt: "bekurapps@gmail.com",
                icon: "assets/email.png",
                url: Uri(
                  scheme: 'mailto',
                  path: 'bekurapps@gmail.com',
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'Purchase VIP Tip for Favourite Tips App',
                  }),
                ),
                phoneText: Container(),
              ),
              ContactUsItems(
                linkTxt: "bekurapps@gmail.com",
                icon: "assets/phone.png",
                url: Uri.parse("https://wa.me/qr/3QBNYCSEMWRCI1"),
                phoneText: RichText(
                  text: TextSpan(
                    text: "",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      decoration: TextDecoration.underline,
                      decorationColor: primaryColor,
                      color: primaryColor,
                    ),
                    children: [
                      TextSpan(
                        text: "+251 932 636 967 | ",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          decoration: TextDecoration.underline,
                          decorationColor: primaryColor,
                          color: primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _launchURL(
                              Uri(scheme: 'tel', path: '+251932636967'),
                            );
                          },
                      ),
                      TextSpan(
                        text: "+251 922 876 643",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          decoration: TextDecoration.underline,
                          decorationColor: primaryColor,
                          color: primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _launchURL(
                              Uri(scheme: 'tel', path: '+251922876643'),
                            );
                          },
                      ),
                    ],
                  ),
                ),
                isPhone: true,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Text(
                  "We also provide software development service, If you want us to develop your system. Contact Us.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins"),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 25.0,
                      ),
                      child: Text(
                        "Powered By:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins"),
                      ),
                    ),
                    Image.asset(
                      "assets/bekurLogo.png",
                      width: MediaQuery.of(context).size.width * 0.35,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('ID Copied to clipboard')),
      // );
    });
  }
}

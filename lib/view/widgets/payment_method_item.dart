import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem(
      {super.key, required this.icon, required this.name, required this.des});

  final String icon, name, des;
  // final Color bgColor, textColor, iconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(
        right: 20.0,
      ),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xfff1f1f1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            icon,
            width: 30.0,
            height: 30.0,
          ),
          SizedBox(
            height: 35.0,
          ),
          Text(
            name,
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
                fontFamily: "PilatExtended",
                color: Colors.black),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            des,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Color(0xff7A7A7B),
                fontFamily: "Poppins"),
          ),
        ],
      ),
    );
  }
}

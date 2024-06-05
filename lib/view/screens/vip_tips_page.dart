import 'package:flutter/material.dart';

class VIPTipsPage extends StatefulWidget {
  const VIPTipsPage({super.key});

  @override
  State<VIPTipsPage> createState() => _VIPTipsPageState();
}

class _VIPTipsPageState extends State<VIPTipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("VIP TIPS")),
    );
  }
}

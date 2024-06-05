import 'package:flutter/material.dart';

class CustomRoundedTextFormField extends StatelessWidget {
  final String? hintText;
  final double borderRadius;
  final Color borderColor;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomRoundedTextFormField({
    super.key,
    @required this.hintText,
    this.borderRadius = 1.0,
    this.borderColor = Colors.grey,
    @required this.controller,
    @required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          validator: validator,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatelessWidget {
  final String hintText;
  final double borderRadius;
  final Color borderColor;
  final TextEditingController controller;
  final bool obscureText;
  final Function() onToggle;
  final String? Function(String?)? validator;

  const CustomPasswordFormField({
    Key? key,
    required this.hintText,
    this.borderRadius = 1.0,
    this.borderColor = Colors.grey,
    required this.controller,
    required this.obscureText,
    required this.onToggle,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: onToggle,
          ),
          border: InputBorder.none,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

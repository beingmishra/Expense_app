import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hint;
  final IconData prefixIcon;

  const ReusableTextField(
      {super.key,
      required this.controller,
      required this.keyboardType,
      required this.hint,
      required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(hintText: hint, prefixIcon: Icon(prefixIcon), border: const OutlineInputBorder()),
    );
  }
}

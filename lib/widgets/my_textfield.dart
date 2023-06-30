import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final controller;
  final bool obscureText;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;

  const MyTextField({
    this.keyboardType,
    super.key,
    this.validator,
    this.onFieldSubmitted,
    this.onTap,
    this.focusNode,
    required this.hintText,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        onTap: onTap,
        decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 236, 231, 231))),
            filled: true,
            fillColor: Colors.white));
  }
}

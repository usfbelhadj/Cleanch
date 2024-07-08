import 'package:flutter/material.dart';


class PhoneTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const PhoneTextField({
    super.key,
    required this.controller,
    this.hintText = '',
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) => val!.isEmpty ? 'Veuillez remplir ce champ svp' : null,
      controller: controller,
      obscureText: obscureText,
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone),
        border: OutlineInputBorder(),
        filled: true,
        hintText: hintText,
      ),
    );
  }
}

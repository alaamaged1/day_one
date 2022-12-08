import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final String validator;
  final TextEditingController controller;
  final visible = false;
  const AuthFormField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.validator,
    required this.controller,
    //  required this.val,s
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
          12.0,
        )),
        label: Text(label),
        hintText: hintText,
      ),
      validator: (val) => val!.isEmpty ? validator : null,
    );
  }
}

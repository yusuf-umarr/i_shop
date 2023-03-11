import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? surfixIcon;
  final int maxLines;
  final bool obscureText;
  var keyBoard;
  CustomTextField(
      {Key? key,
      this.controller,
      required this.hintText,
      this.maxLines = 1,
      this.keyBoard,
      this.surfixIcon,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyBoard,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: surfixIcon,
          suffixIconColor: GlobalVariables.primaryColor,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}

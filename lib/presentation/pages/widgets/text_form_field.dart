import 'package:flutter/material.dart';
import 'package:todo_app/utils/constant/const.dart';

class DefaultFormField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? type;
  void Function(String)? onSubmit;
  void Function(String)? onChange;
  void Function()? onTap;
  bool isPassword = false;
  final String? Function(String?)? validate;
  final IconData? prefix;
  final IconData? suffix;
  void Function()? suffixPressed;
  bool isClickable = true;
  bool isSuffix = false;
  bool readOnly = false;

  DefaultFormField({
    Key? key,
    required this.controller,
    this.isClickable = true,
    this.isPassword = false,
    this.isSuffix = false,
    this.readOnly = false,
    required this.label,
    this.hintText,
    this.onChange,
    this.onSubmit,
    this.onTap,
    this.prefix,
    this.suffix,
    this.suffixPressed,
    this.type,
    this.validate,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 12),
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        readOnly: readOnly,
        decoration: InputDecoration(
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: COLORCONST.AMBER, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: COLORCONST.RED, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            filled: true,
            fillColor: COLORCONST.WHITE,
            hintText: hintText,
            hintStyle: const TextStyle(color: COLORCONST.GREY),
            contentPadding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 20),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: COLORCONST.BLACK, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: COLORCONST.AMBER, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            labelText: label,
            labelStyle: const TextStyle(color: COLORCONST.GREY),
            prefixIcon: Icon(
              prefix,
              color: COLORCONST.GREY,
            ),
            suffixIcon: isSuffix
                ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
                : null));
  }
}

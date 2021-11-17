import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  String? label;
  TextEditingController? controller;
  TextInputType? type;
  void Function(String)? onSubmit;
  void Function(String)? onChange;
  void Function()? onTap;
  bool isPassword = false;
  String? Function(String?)? validate;
  IconData? prefix;
  IconData? suffix;
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
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber.shade700, width: 2.0),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            filled: true,
            fillColor: Colors.white10,
            hintText: 'New Task',
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 20),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white10, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber.shade700, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            labelText: label,
            labelStyle: const TextStyle(color: Colors.grey),
            prefixIcon: Icon(
              prefix,
              color: Colors.grey,
            ),
            suffixIcon: isSuffix
                ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
                : null));
  }
}

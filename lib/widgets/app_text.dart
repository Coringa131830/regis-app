import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppText extends StatelessWidget {
  String label;
  String hint;
  bool password;
  TextEditingController controller;
  FormFieldValidator validator;
  TextInputType keyboardType;
  TextInputAction inputAction;
  FocusNode focusNode;
  FocusNode nextFocus;

  List<TextInputFormatter> inputFormatters;

  int maxLines;

  bool center;

  AppText(
    this.label,
    this.hint, {
    this.password = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.inputAction,
    this.focusNode,
    this.nextFocus,
    this.maxLines = 1,
    this.inputFormatters,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: center == true ? TextAlign.center : TextAlign.start,
      inputFormatters: inputFormatters ?? [],
      controller: controller,
      obscureText: password,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: inputAction,
      focusNode: focusNode,
      maxLines: maxLines,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 25,
        ),
        hintStyle: TextStyle(
          fontSize: 16,
        ),
      ),
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
      ),
    );
  }
}

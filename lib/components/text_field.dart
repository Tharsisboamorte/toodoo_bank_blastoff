import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CustomInputTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool validation;
  final int maxLength;
  const CustomInputTextField({Key? key, required this.controller, this.validation = false, this.maxLength = TextField.noMaxLength}) : super(key: key);

  @override
  State<CustomInputTextField> createState() => _CustomInputTextFieldState();
}

class _CustomInputTextFieldState extends State<CustomInputTextField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: 2,
      validator: (text) {
        widget.validation;
      },
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        errorText: " O código informado é inválido.",
        errorBorder:OutlineInputBorder(borderSide: BorderSide(color: CustomColors.redAlert)) ,
        errorStyle: TextStyle(color: CustomColors.redAlert, fontFamily: Fonts.inputText, fontSize: 12),
        hintText: "Digite aqui",
        filled: true,
        hintStyle: TextStyle(color: CustomColors.hintGrey, fontFamily: Fonts.inputText),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: CustomColors.neutral700,
                strokeAlign: StrokeAlign.outside)),
        fillColor: CustomColors.neutral700,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.redAlert)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: CustomColors.neutral700,
                strokeAlign: StrokeAlign.outside)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: CustomColors.neutral700,
                strokeAlign: StrokeAlign.outside)),
      ),
    );
  }
}

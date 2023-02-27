import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CustomElevatedButton extends StatefulWidget {
  final String label;
  final String page;
  const CustomElevatedButton(
      {Key? key, required this.label, required this.page})
      : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(0),
            backgroundColor: MaterialStatePropertyAll(CustomColors.blue300),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color:  CustomColors.blue300)))),
        onPressed: () {
          Navigator.of(context).pushNamed(widget.page);
          //ADD POST TO API
          //CONDITION FOR TEXT ACCEPTANCE
        },
        child: Text(widget.label,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)));
  }
}
import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  final String label;
  const RadioButton({Key? key, required this.label}) : super(key: key);

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
            value: widget.label, groupValue: "Date", onChanged: (value) {
          setState(() {

          });
        }),
        Text("")
      ],
    );
  }
}

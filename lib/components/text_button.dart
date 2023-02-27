import 'package:flutter/cupertino.dart';

class RowTextButton extends StatelessWidget {
  final String leading;
  final String title;
  final String trailing;
  const RowTextButton({Key? key, required this.leading, required this.title, required this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(leading),
        Text(title),
        Image.asset(trailing),
      ],
    );
  }
}

//
// Image.asset("assets/icons/barCode.png"),
// Text("Escanear código de barras"),
// Image.asset("assets/icons/numberedKeyboard.png"),
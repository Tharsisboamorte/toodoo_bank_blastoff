import 'package:flutter/cupertino.dart';
import 'package:toodoo_bank/utils/utils.dart';

class InfoCard extends StatelessWidget {
  final String category;
  final String info;
  final double fontSize;
  final double fontInfoSize;
  final TextOverflow textOverflow;
  final int maxLine;
  const InfoCard(
      {Key? key,
        required this.category,
        required this.info,
        this.fontSize = 14,
        this.fontInfoSize = 14,
        this.textOverflow = TextOverflow.ellipsis,
        this.maxLine = 1,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            category,
            style: TextStyle(
                color: CustomColors.hintGrey,
              fontFamily: Fonts.inputText,
              fontSize: fontSize)
          ),
        ),
        Text(
          info,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColors.blackText,
              fontFamily: Fonts.inputText,
              fontSize: fontInfoSize
          ),
          softWrap: true,
          overflow: textOverflow,
          maxLines: maxLine,
        ),
      ],
    );
  }
}

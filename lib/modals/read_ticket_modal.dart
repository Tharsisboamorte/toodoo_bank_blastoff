import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toodoo_bank/utils/utils.dart';

class ReadTicketModal extends StatelessWidget {
  const ReadTicketModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 33.0, right: 33.0, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: CustomColors.dividerModal),
                width: 48,
                height: 5,
                child: const Divider(
                  color: Colors.transparent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 27.0),
              child: Text("Pagamentos", style: TextStyle(color: CustomColors.blackText, fontSize: 24, fontFamily: Fonts.defaultText, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: InkWell(
                onTap: (){
                   Navigator.of(context).pushNamed("/barCodeRead");
                   SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset("assets/icons/barcodeIcon.svg"),
                    Text("Escanear código de barras", style: TextStyle(color: CustomColors.blackText, fontSize: 16, fontFamily: Fonts.defaultText, fontWeight: FontWeight.bold)),
                    Icon(Icons.arrow_forward_ios_outlined, color: CustomColors.blue300,)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Divider(color: CustomColors.dividerModal),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed("/barCodeType");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset("assets/icons/numberedKeyboard.svg"),
                    Text("Digitar código de barras", style: TextStyle(color: CustomColors.blackText, fontSize: 16, fontFamily: Fonts.defaultText, fontWeight: FontWeight.bold)),
                    Icon(Icons.arrow_forward_ios_outlined, color: CustomColors.blue300,)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 20),
              child: Divider(color: CustomColors.dividerModal),
            ),
          ],
        ),
      ),
    );
  }
}

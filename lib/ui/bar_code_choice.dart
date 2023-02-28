import 'package:flutter/material.dart';
import 'package:toodoo_bank/modals/read_ticket_modal.dart';
import 'package:toodoo_bank/network/payment_network.dart';
import 'package:toodoo_bank/utils/utils.dart';

class BarCodeChoice extends StatefulWidget {
  @override
  _BarCodeChoiceState createState() => _BarCodeChoiceState();
}

class _BarCodeChoiceState extends State<BarCodeChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(CustomColors.blue300)),
            onPressed: () {
              Future<void> token = CallApi().getToken();
              debugPrint("Token $token");
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                        height: 300, child: ReadTicketModal());
                  });
            },
            child: Text(
              "Escolher forma de pagamento",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: Fonts.defaultText),
            )),
      ),
    );
  }
}

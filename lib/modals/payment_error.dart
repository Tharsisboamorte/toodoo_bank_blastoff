import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/utils.dart';

class PaymentError extends StatelessWidget {
  const PaymentError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CustomColors.dividerModal),
                width: 48,
                height: 6,
                child: Divider(
                  color: Colors.transparent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 27.0, bottom: 16.0),
              child: Image.asset("assets/images/warning.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 59.0, right: 59),
              child: Text(""" Não foi possível pagar
      neste momento""",
                  style: TextStyle(
                      color: CustomColors.blackText,
                      fontFamily: Fonts.defaultText,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 32, left: 32),
              child: Text(
                "Você não tem saldo para realizar este pagamento. Deseja agendar o pagamento?",
                overflow: TextOverflow.visible,
                maxLines: 2,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: CustomColors.neutral300,
                    fontFamily: Fonts.inputText),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 70.0, right: 54, top: 16),
                  child: TextButton(
                      onPressed: () {

                      },
                      child: Text(
                        "Não",
                        style: TextStyle(
                            color: CustomColors.redAlert,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 32.0, top: 16),
                  child: SizedBox(
                    height: 56,
                    width: 151,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: const MaterialStatePropertyAll(0),
                            backgroundColor:
                            MaterialStatePropertyAll(CustomColors.blue300),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                        color: CustomColors.blue300)))),
                        onPressed: () {

                        },
                        child: const Text("Sim",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toodoo_bank/utils/utils.dart';

class ReadError extends StatelessWidget {
  const ReadError({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.only(left: 8.0, right: 25, top: 27),
              child: Text("Falha na leitura do código",
                  style: TextStyle(
                      color: CustomColors.blackText,
                      fontFamily: Fonts.defaultText,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 130, left: 130),
              child: Text(
                "Não foi possível realizar a leitura do código de barras. Digite o código manualmente ou tente novamente realizar a leitura do boleto.",
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
                      const EdgeInsets.only(left: 130.0, right: 94, top: 16),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Tentar novamente",
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
                    width: 320,
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
                          Navigator.of(context).pushNamed("/barCodeType");
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitDown
                          ]);
                        },
                        child: Text("Digitar código de barras",
                            style: const TextStyle(
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

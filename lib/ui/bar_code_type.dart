import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toodoo_bank/network/payment_network.dart';
import 'package:toodoo_bank/utils/utils.dart';

import '../components/text_field.dart';

class BarCodeType extends StatefulWidget {
  const BarCodeType({Key? key}) : super(key: key);

  @override
  State<BarCodeType> createState() => _BarCodeTypeState();
}

class _BarCodeTypeState extends State<BarCodeType> {
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Pagamentos",
            style: TextStyle(
                color: CustomColors.blackText, fontWeight: FontWeight.bold)),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/barCodeChoice");
            },
            icon:
                Icon(Icons.arrow_back_ios_new, color: CustomColors.blackText)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            bottom: 40.0, left: 32.0, right: 32.0, top: 40.0),
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text("Digite o código do boleto para pagamento",
                    style: TextStyle(
                        color: CustomColors.blackText,
                        fontWeight: FontWeight.bold,
                        fontSize: 24)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text("Código de barras",
                    style:
                        TextStyle(color: CustomColors.blackText, fontSize: 14)),
              ),
              TextFormField(
                controller: textController,
                maxLines: 2,
                validator: (text) {
                  BarCode().validator(textController.text);
                },
                maxLength: 60,

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
              ),
              const Spacer(flex: 2),
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/barCodeRead");
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeRight
                          ]);
                        },
                        style: ButtonStyle(
                            overlayColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                            textStyle: MaterialStatePropertyAll(TextStyle(
                                color: CustomColors.blue200,
                                fontWeight: FontWeight.bold))),
                        child: const Text("Usar leitor de código"),
                      ),
                    ),
                    SizedBox(
                      width: 311,
                      height: 56,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: const MaterialStatePropertyAll(0),
                              backgroundColor: MaterialStatePropertyAll(
                                  CustomColors.blue300),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                          color: CustomColors.blue300)))),
                          onPressed: () async {
                            String text = textController.text;
                            CallApi().getValidBarCode(text);
                            developer.log(text, name: "BARCODE_LOG");
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).pushNamed("/paymentTicket");
                            }
                          },
                          child: const Text("Confirmar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

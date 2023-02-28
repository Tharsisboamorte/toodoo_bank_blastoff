import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toodoo_bank/network/models/barcode_model.dart';
import 'package:toodoo_bank/network/payment_network.dart';
import 'package:toodoo_bank/utils/utils.dart';

import '../components/text_field.dart';

class BarCodeType extends StatefulWidget {
  const BarCodeType({Key? key}) : super(key: key);

  @override
  State<BarCodeType> createState() => _BarCodeTypeState();
}

class _BarCodeTypeState extends State<BarCodeType> {
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
    TextEditingController textController = TextEditingController();
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
              Form(
                key: _formKey,
                child: TextFormField(
                  maxLength: 60,
                  maxLines: 2,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: CustomColors.redAlert),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: CustomColors.redAlert)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: CustomColors.redAlert)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: CustomColors.neutral700)
                    )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O código informado é inválido.';
                    }
                    if (!BarCode().validator(value)) {
                      return  'O código informado é inválido.';
                    }
                    return null;
                  },
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
                            BarcodeModelEntity barcodeModel = BarcodeModelEntity();
                            debugPrint(text);
                            CallApi().getValidBarCode(text).then((value) => {
                              barcodeModel = value
                            });
                            if (_formKey.currentState!.validate()) {
                              // Navigator.of(context).pushNamed("/paymentTicket", arguments: {
                              //   "barcode" : barcodeModel.barcode,
                              //   "paymentType" : barcodeModel.paymentType,
                              //   "dueDate" : barcodeModel.dueDate,
                              //   "paymentLimitDate" : barcodeModel.paymentLimitDate,
                              //   "value" : barcodeModel.value,
                              //   "recipient" : barcodeModel.recipient,
                              //   "discount" : barcodeModel.discount,
                              //   "interest" : barcodeModel.interest,
                              //   "totalAmountDue" : barcodeModel.totalAmountDue,
                              // });
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

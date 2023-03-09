import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:toodoo_bank/components/text_field.dart';
import 'package:toodoo_bank/modals/payment_error.dart';
import 'package:toodoo_bank/network/models/barcode_model.dart';

import '../components/info_card.dart';
import '../utils/utils.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isObscured = true;
  TextEditingController controller = TextEditingController();
  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  int _selectedValue = 0;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
  }

  @override
  Widget build(BuildContext context) {
    final barcodeModel = ModalRoute.of(context)?.settings.arguments
        as Future<BarcodeModelEntity>;

    Size screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
        future: barcodeModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Failed to get valid barcode: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            BarcodeModelEntity barcodeModel = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text("Pagamentos",
                    style: TextStyle(
                        color: CustomColors.blackText,
                        fontWeight: FontWeight.bold)),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios_new,
                        color: CustomColors.blackText)),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 32.0, right: 32, bottom: 24),
                  child: SizedBox(
                    width: screenSize.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text("Saldo atual",
                                  style: TextStyle(
                                      color: CustomColors.hintGrey,
                                      fontFamily: Fonts.inputText,
                                      fontSize: 14)),
                            ),
                            Row(
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: isObscured ? "" : "R\$",
                                        style: TextStyle(
                                            fontSize: 21,
                                            color: CustomColors.blackText),
                                        children: [
                                      TextSpan(
                                          text: isObscured
                                              ? "•••••••"
                                              : "16.927,00",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.blackText))
                                    ])),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscured = !isObscured;
                                      });
                                    },
                                    icon: isObscured
                                        ? const Icon(
                                            Icons.visibility_off_outlined)
                                        : const Icon(Icons.visibility_outlined))
                              ],
                            )
                          ],
                        ),
                        Divider(color: CustomColors.neutral700, thickness: 1),
                        const Padding(
                          padding: EdgeInsets.only(top: 24.0, bottom: 24.0),
                          child: Text(
                            "Dados do seu boleto",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: InfoCard(
                              category: "Valor",
                              info: "R\$ ${barcodeModel.value}"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: InfoCard(
                              category: "Data de vencimento",
                              info: DateFormat('dd/MM/yyyy').format(
                                  DateTime.parse(barcodeModel.dueDate))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: InfoCard(
                              category: "Beneficiário",
                              info: barcodeModel.recipient),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 24.0),
                          child: InfoCard(
                              category: "Código de barras",
                              info: barcodeModel.barcode,
                              textOverflow: TextOverflow.visible,
                              maxLine: 2),
                        ),
                        Divider(color: CustomColors.neutral700, thickness: 1),
                        const Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Text(
                            "Pagar em",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          title: Text("Pagar agora"),
                          leading: Radio(
                              activeColor: CustomColors.blue300,
                              value: 0,
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value as int;
                                });
                              }),
                          trailing: Text(
                            formattedDate,
                            style: TextStyle(
                                color: CustomColors.blue300,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(color: CustomColors.neutral700, thickness: 1),
                        ListTile(
                          title: Text("Agendar"),
                          leading: Radio(
                              activeColor: CustomColors.blue300,
                              value: 1,
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value as int;
                                });
                              }),
                          trailing:
                              SvgPicture.asset("assets/icons/calenderIcon.svg"),
                        ),
                        Divider(color: CustomColors.neutral700, thickness: 1),
                        const Padding(
                          padding: EdgeInsets.only(top: 14.0, bottom: 4.0),
                          child: Text("Descrição"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: TextField(
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: "Digite aqui",
                              filled: true,
                              hintStyle: TextStyle(
                                  color: CustomColors.hintGrey,
                                  fontFamily: Fonts.inputText),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: CustomColors.neutral700,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside)),
                              fillColor: CustomColors.neutral700,
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: CustomColors.redAlert)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: CustomColors.neutral700,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: CustomColors.neutral700,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside)),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 311,
                            height: 56,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation:
                                        const MaterialStatePropertyAll(0),
                                    backgroundColor: MaterialStatePropertyAll(
                                        CustomColors.blue300),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            side: BorderSide(
                                                color: CustomColors.blue300)))),
                                onPressed: () {
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft: Radius.circular(10))),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const SizedBox(
                                            height: 350, child: PaymentError());
                                      });
                                },
                                child: const Text("Realizar pagamento",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data available yet'));
          }
        });
  }
}

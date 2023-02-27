import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toodoo_bank/ui/bar_code_choice.dart';
import 'package:toodoo_bank/ui/bar_code_read.dart';
import 'package:toodoo_bank/ui/bar_code_type.dart';
import 'package:toodoo_bank/ui/payment_ticket.dart';
import 'package:toodoo_bank/utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
     DeviceOrientation.portraitUp
  ]
  ).then((value) => runApp(const ToodooBankApp()));
}

class ToodooBankApp extends StatelessWidget {
  const ToodooBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: Fonts.defaultText,
          backgroundColor: Colors.white,
          hintColor: CustomColors.hintGrey,
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: CustomColors.blackText,
            displayColor: CustomColors.blackText,
          ),
      ),

      initialRoute: "/barCodeChoice",
      routes: {
        "/barCodeType" :(_) => const BarCodeType(),
        "/barCodeChoice" :(_) => BarCodeChoice(),
        "/barCodeRead" :(_) => const BarCodeRead(),
        "/paymentTicket" :(_) => const PaymentPage(),
      },
    );
  }
}

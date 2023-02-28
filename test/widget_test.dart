// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:combined_barcode_scanner/combined_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:toodoo_bank/main.dart';
import 'package:toodoo_bank/ui/payment_ticket.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ToodooBankApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
  //
  // testWidgets('Teste para BarcodeScannerWidget', (WidgetTester tester) async {
  //   var barcodeData = {"barCodeData": "Exemplo de código de barras"};
  //   BarcodeScannerWidgetController _scannerWidgetController =  BarcodeScannerWidgetController(() {
  //
  //     const ScannerConfiguration(enableFormats: {
  //       BarcodeFormat.code128,
  //       BarcodeFormat.code39,
  //       BarcodeFormat.code93,
  //       BarcodeFormat.codabar,
  //     });
  //   });
  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: BarcodeScannerWidget(
  //         onScan: (barcode) {
  //           expect(barcode.code, "Exemplo de código de barras");
  //           // Simula a navegação para a próxima página
  //           Navigator.of(tester.element(find.byType(BarcodeScannerWidget))).pushNamed(
  //             "/paymentTicket"
  //           );
  //         },
  //         configuration: const ScannerConfiguration(
  //           cameraConfiguration: CameraConfiguration(
  //             resolution: CameraResolution.medium,
  //             frameRate: 60,
  //             mode: BarcodeDetectionMode.pauseDetection,
  //             type: CameraType.back,
  //           ),
  //           enableFormats: {
  //             BarcodeFormat.code128,
  //             BarcodeFormat.code39,
  //             BarcodeFormat.code93,
  //             BarcodeFormat.codabar,
  //           },
  //         ),
  //         scanners: [],
  //         controller: ,
  //       ),
  //       // Define a rota da próxima página para ser acessada durante o teste
  //       routes: {
  //         "/paymentTicket": (context) => Scaffold(
  //           body: Text("Payment Ticket Page"),
  //         ),
  //       },
  //     ),
  //   );
  //
  //   // Find the barcode scanner widget
  //   final barcodeScannerWidget = find.byType(BarcodeScannerWidget);
  //
  //   // Verify that the widget exists
  //   expect(barcodeScannerWidget, findsOneWidget);
  //
  //   // Wait for the widget tree to rebuild
  //   await tester.pumpAndSettle();
  //
  //   // Verify that the navigator has pushed the correct screen with the correct arguments
  //   expect(find.byType(PaymentPage), findsOneWidget);
  //   expect(find.text('12345'), findsOneWidget);
  //
  //   // Verifica se a próxima página foi acessada corretamente
  //   expect(find.text("Payment Ticket Page"), findsOneWidget);
  // });
}

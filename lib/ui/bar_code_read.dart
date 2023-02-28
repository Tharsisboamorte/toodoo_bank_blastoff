import 'package:camera/camera.dart';
import 'package:combined_barcode_scanner/combined_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toodoo_bank/network/payment_network.dart';
import 'package:toodoo_bank/utils/utils.dart';
import 'package:torch_light/torch_light.dart';

class BarCodeRead extends StatefulWidget {
  const BarCodeRead({Key? key}) : super(key: key);

  @override
  State<BarCodeRead> createState() => _BarCodeReadState();
}

class _BarCodeReadState extends State<BarCodeRead> {
  late CameraController _controller;
  late BarcodeScannerWidgetController _scannerWidgetController;

  late Future<void> _initializeControllerFuture;

  bool isTorchEnabled = false;

  List<BarcodeScanner> scanners = [];

  @override
  void initState() {
    super.initState();
    _scannerWidgetController = BarcodeScannerWidgetController(() {
      const ScannerConfiguration(enableFormats: {
        BarcodeFormat.code128,
        BarcodeFormat.code39,
        BarcodeFormat.code93,
        BarcodeFormat.codabar,
      });
    });
    _controller = CameraController(
        const CameraDescription(
          name: '0',
          lensDirection: CameraLensDirection.back,
          sensorOrientation: 0,
        ),
        ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    _scannerWidgetController.dispose();
    _controller.dispose();
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
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{"Token": ""}) as Map<String, dynamic>;
    _isTorchAvailable(context);
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: Container(
        color: CustomColors.blackText,
        height: height,
        width: width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 48.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/barCodeChoice");
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitDown
                          ]);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 143.0, top: 12),
                    child: Stack(
                      children: [
                        Image.asset("assets/images/dialogBoard.png"),
                        Positioned(
                          top: 13,
                          bottom: 15,
                          left: 30,
                          right: 10,
                          child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  text: "Posicione o ",
                                  children: [
                                    TextSpan(
                                        text: "código de barras ",
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: "na área indicada.",
                                    ),
                                  ])),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 662,
              height: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  color: Colors.white),
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(
                      _controller,
                      child:Stack(
                        children: [
                          Positioned(
                            right: 0,
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 45.0, right: 46.0),
                              child: Divider(
                              color: CustomColors.blue300,
                              thickness: 5,
                              ),
                            )
                          ),
                          BarcodeScannerWidget(
                              onScan: (barcode) {
                                debugPrint(barcode.code);
                                debugPrint(arguments["Token"]);
                                CallApi().getValidBarCode(barcode.code).then(
                                        (barcodeData) => Navigator.of(context).pushNamed(
                                        "/paymentTicket",
                                        arguments: {"barcode": barcodeData}));
                              },
                              configuration: const ScannerConfiguration(
                                  cameraConfiguration: CameraConfiguration(
                                      resolution: CameraResolution.medium,
                                      frameRate: 60,
                                      mode: BarcodeDetectionMode.pauseDetection,
                                      type: CameraType.back),
                                  enableFormats: {
                                    BarcodeFormat.code128,
                                    BarcodeFormat.code39,
                                    BarcodeFormat.code93,
                                    BarcodeFormat.codabar,
                                  }),
                              scanners: [],
                              controller: _scannerWidgetController),
                        ],
                      )
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35, left: 79),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          isTorchEnabled = !isTorchEnabled;
                        });
                        isTorchEnabled ? FlashLight().enableTorch() : FlashLight().disableTorch();
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SvgPicture.asset("assets/icons/flashIcon.svg"),
                          ),
                          const Text(
                            "Ligar flash",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 110.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("/barCodeType");
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitDown
                          ]);
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SvgPicture.asset(
                                  "assets/icons/whiteKeyboardIcon.svg"),
                            ),
                            const Text(
                              "Digitar código de barras",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<bool> _isTorchAvailable(BuildContext context) async {
    try {
      return await TorchLight.isTorchAvailable();
    } on Exception catch (_) {
      debugPrint('Could not check if the device has an available torch');
      rethrow;
    }
  }
}

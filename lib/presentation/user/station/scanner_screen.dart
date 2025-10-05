import 'dart:math';

import 'package:flutter/material.dart';

import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:voltly_app/presentation/user/station/connect_charger.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool scanned = false;

  @override
  void dispose() {
    super.dispose();
    controller!.disposed;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onQRViewCreated(QRViewController ctrl) {
    this.controller = ctrl;
    // ctrl.scannedDataStream.listen((scanData) {
    //   if (!scanned) {
    //     scanned = true;
    //   }
    // });
    Future.delayed(
      Duration(seconds: 2),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ConnectCharger()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top app bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      "Scan QR Code",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 48), // Placeholder to balance the back button
                ],
              ),
            ),
            Divider(color: Color(0xff264A5F)),

            // QR scanner area
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Color(0xFF121C24),
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

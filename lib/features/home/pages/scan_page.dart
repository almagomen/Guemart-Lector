import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatelessWidget {
  const QRScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MobileScannerController scannerController = MobileScannerController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.flash_on),
          //   onPressed: () => scannerController.toggleTorch(),
          // ),
        ],
      ),
      body: MobileScanner(
        controller: scannerController,
        onDetect: (capture) {
          final barcodes = capture.barcodes;
          if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
            final String code = barcodes.first.rawValue!;
            scannerController.dispose(); // Stop the scanner to free resources
            Navigator.pop(context, code); // Return the scanned code
          }
        },
      ),
    );
  }
}
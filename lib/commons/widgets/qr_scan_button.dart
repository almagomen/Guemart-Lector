import 'package:flutter/material.dart';

class QRScanButton extends StatelessWidget {
  final VoidCallback scanQRCode;
  const QRScanButton({super.key, required this.scanQRCode});
 
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style, // !.copyWith(backgroundColor: WidgetStateProperty.all(Colors.red),)
      onPressed: scanQRCode,
      child: Text('Scan QR'),
    );
  }
}

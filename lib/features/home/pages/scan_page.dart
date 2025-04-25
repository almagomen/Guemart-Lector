import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScanPage extends HookWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Hook para manejar el estado de los códigos escaneados
    final scannedCodes = useState<List<String>>([]);
    final isScanning = useState<bool>(false);

    // Función para manejar la detección de códigos QR
    void onDetect(BarcodeCapture capture) {
      final Barcode? barcode = capture.barcodes.firstOrNull;
      final String? code = barcode?.rawValue;
      if (code != null && !scannedCodes.value.contains(code)) {
        scannedCodes.value = [...scannedCodes.value, code];

        // Navegar automáticamente a la pantalla de inicio usando Flutter Modular
        Modular.to.pop(scannedCodes.value);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Escanear Código QR')),
      body: Column(
        children: [
          if (isScanning.value)
            Expanded(
              flex: 2,
              child: MobileScanner(
                onDetect: onDetect,
              ),
            ),
          ElevatedButton(
            onPressed: () {
              isScanning.value = true;
            },
            child: const Text('Escanear'),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: scannedCodes.value.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(scannedCodes.value[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
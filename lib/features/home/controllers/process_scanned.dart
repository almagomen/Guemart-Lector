import 'package:flutter/material.dart';

void showCustomToast(BuildContext context, String message, Color backgroundColor) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 100.0, // Cambiado para que aparezca desde la parte superior con un padding de 100
      left: MediaQuery.of(context).size.width * 0.1,
      right: MediaQuery.of(context).size.width * 0.1,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  Future.delayed(const Duration(milliseconds: 1500), () {
    overlayEntry.remove();
  });
}

void processScanned(BuildContext context, String result, ValueNotifier<Map<String, int>> products, ValueNotifier<List<String>> scannedResults) {
  final lowerCaseResult = result.toLowerCase();

  if (products.value.containsKey(lowerCaseResult)) {
    final currentQuantity = products.value[lowerCaseResult]!;

    if (currentQuantity > 0) {
      products.value = {...products.value, lowerCaseResult: currentQuantity - 1};
      scannedResults.value = [...scannedResults.value, result];
      // Uncomment if needed
      // showCustomToast(context, 'Producto "$result" encontrado y añadido al drawer', Colors.green);
    } else {
      showCustomToast(context, 'Producto "$result" está agotado', Colors.red);
    }
  } else {
    showCustomToast(context, 'Producto "$result" no encontrado', Colors.orange);
  }
}
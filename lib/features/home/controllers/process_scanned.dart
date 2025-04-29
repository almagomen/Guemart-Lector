import 'package:flutter/material.dart';


void showAnimatedDialog(BuildContext context, String message, Color backgroundColor, IconData iconData, String actionText) {
  final dialogWidget = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Close"),
          ),
        ],
      ),
    ),
  );

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "",
    pageBuilder: (context, animation1, animation2) => Container(),
    transitionBuilder: (context, animation1, animation2, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation1, curve: Curves.easeIn),
        child: dialogWidget,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}

void processScanned(BuildContext context, String result, ValueNotifier<Map<String, int>> products, ValueNotifier<List<String>> scannedResults) {
  final lowerCaseResult = result.toLowerCase();

  if (products.value.containsKey(lowerCaseResult)) {
    final currentQuantity = products.value[lowerCaseResult]!;

    if (currentQuantity > 0) {
      products.value = {...products.value, lowerCaseResult: currentQuantity - 1};
      scannedResults.value = [...scannedResults.value, result];
      // Uncomment if needed
      // showAnimatedDialog(context, 'Producto "$result" encontrado y añadido al drawer', Colors.green);
    } else {
      showAnimatedDialog(context, 'Producto "$result" está agotado', Colors.red, Icons.error, "Cerrar");
    }
  } else {
    showAnimatedDialog(context, 'Producto "$result" no encontrado', Colors.orange, Icons.warning, "Cerrar");
  }
}
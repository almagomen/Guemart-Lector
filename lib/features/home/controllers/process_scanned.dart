import 'package:flutter/material.dart';


void showSnackBar(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating, content: Text(message)),
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
          // _showSnackBar(context, 'Producto "$result" encontrado y añadido al drawer');
        } else {
          showSnackBar(context, 'Producto "$result" está agotado');
        }
      } else {
        showSnackBar(context, 'Producto "$result" no encontrado');
      }
    }
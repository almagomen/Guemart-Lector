import 'package:app/features/welcome/pages/view_page.dart';
import 'package:flutter/material.dart';

class DrawerScannerResult extends StatelessWidget {
  const DrawerScannerResult({
    super.key,
    required this.scannedResults,
    required this.products,
  });

  final ValueNotifier<List<String>> scannedResults;
  final ValueNotifier<Map<String, int>> products;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  // decoration: BoxDecoration(color: Colors.blue),
                  child: Text('Scanned Results', style: TextStyle(color: Colors.white, fontSize: 24)),
                ),
                ...scannedResults.value.map((result) => ListTile(
                      title: Text(result),
                      leading: const Icon(Icons.qr_code),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Remove only the first occurrence of the selected item
                          final updatedList = List<String>.from(scannedResults.value);
                          updatedList.remove(result); // This removes the first occurrence
                          scannedResults.value = updatedList;

                          // Increment the product quantity back in the product list
                          final lowerCaseResult = result.toLowerCase();
                          if (products.value.containsKey(lowerCaseResult)) {
                            final currentQuantity = products.value[lowerCaseResult]!;
                            products.value = {...products.value, lowerCaseResult: currentQuantity + 1};
                          }

                          // Show a snackbar message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Producto "$result" eliminado del drawer y cantidad actualizada')),
                          );
                        },
                      ),
                    )),
              ],
            ),
          ),
          ValueListenableBuilder<Map<String, int>>(
            valueListenable: products,
            builder: (context, productValues, child) {
              final allZero = productValues.values.every((quantity) => quantity == 0);
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: allZero
                      ? () => Navigator.of(context).pushNamed('/packages')
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: allZero ? Colors.green : Colors.grey,
                  ),
                  child: const Text('Avanzar'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Next Page')),
      body: const Center(child: Text('¡Has avanzado a la siguiente página!')),
    );
  }
}
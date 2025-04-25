import 'package:app/features/home/widgets/scan_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class HomePage extends HookWidget { 
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Hook to manage the list of scanned results
    final scannedResults = useState<List<String>>([]);
    final productList = useState<Map<String, int>>({
      'lente': 2,
      'gorra': 3,
      'camisa': 1,
      'pantalon': 2,
      'guante': 4,
    });

    Future<void> scanQRCode() async {
      // Navigate to a scanner page and wait for the result
      final result = await Modular.to.push<String>(
        MaterialPageRoute(builder: (context) => const QRScannerPage()),
      );

      if (result != null && result.isNotEmpty) {
        final lowerCaseResult = result.toLowerCase();
        if (productList.value.containsKey(lowerCaseResult)) {
          // Decrease the quantity of the product
          final currentQuantity = productList.value[lowerCaseResult]!;
          if (currentQuantity > 0) {
            productList.value = {
              ...productList.value,
              lowerCaseResult: currentQuantity - 1,
            };
            scannedResults.value = [...scannedResults.value, result];
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(behavior: SnackBarBehavior.floating, content: Text('Producto "$result" encontrado y añadido al drawer')),
            // );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(behavior: SnackBarBehavior.floating, content: Text('Producto "$result" está agotado')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(behavior: SnackBarBehavior.floating, content: Text('Producto "$result" no encontrado')),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        actions: [],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Scanned Results',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
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
                      if (productList.value.containsKey(lowerCaseResult)) {
                        final currentQuantity = productList.value[lowerCaseResult]!;
                        productList.value = {
                          ...productList.value,
                          lowerCaseResult: currentQuantity + 1,
                        };
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Producto "$result" eliminado del drawer y cantidad actualizada')),
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Icon(Icons.qr_code_scanner, size: 100),
            const Text('Welcome to QR Scanner', style: TextStyle(fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: scanQRCode,
                  child: const Text('Scan QR'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => Modular.to.pushNamed('/create'),
                  child: const Text('Create QR'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'Lista de productos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...productList.value.entries.map((entry) => Card(
                color: entry.value == 0 ? Colors.lightGreen[100] : Colors.amber[100],
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                elevation: 0,
                child: ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0), side: BorderSide.none),
                  leading: Icon(
                    _getProductIcon(entry.key), // Function to get the icon based on the product name
                    color: Colors.blue,
                  ),
                  title: Text(
                    entry.key.toUpperCase(), // Convert product name to uppercase
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child: Text(
                          '${entry.value}',
                          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

IconData _getProductIcon(String productName) {
  switch (productName.toLowerCase()) {
    case 'lente':
      return Icons.visibility; // Example icon for "lente"
    case 'gorra':
      return Icons.sports_motorsports; // Example icon for "gorra"
    case 'camisa':
      return Icons.checkroom; // Example icon for "camisa"
    case 'pantalon':
      return Icons.work; // Replace with a suitable icon
    case 'guante':
      return Icons.handshake; // Example icon for "guante"
    default:
      return Icons.shopping_bag; // Default icon
  }
}


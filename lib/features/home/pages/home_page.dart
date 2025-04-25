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
    final productList = {
      'lente': 2,
      'gorra': 3,
      'camisa': 1,
      'pantalon': 2,
      'guante': 4,
    };

    Future<void> scanQRCode() async {
      // Navigate to a scanner page and wait for the result
      final result = await Modular.to.push<String>(
        MaterialPageRoute(builder: (context) => const QRScannerPage()),
      );

      if (result != null && result.isNotEmpty) {
        if (productList.containsKey(result.toLowerCase())) {
          scannedResults.value = [...scannedResults.value, result];
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Producto "$result" no encontrado')),
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

            ...productList.entries.map((entry) => Card(
                  color: Colors.amber[100],
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: ListTile(
                    title: Text(entry.key),
                    subtitle: Text('Cantidad: ${entry.value}'),
                    leading: const Icon(Icons.notifications),
                  ),
                )
              ),
          ],
        ),
      ),
    );
  }
}


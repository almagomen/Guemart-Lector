import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:app/features/home/controllers/process_scanned.dart';
import 'package:app/features/home/widgets/drawer_scanner_result.dart';
import 'package:app/features/home/widgets/product_card.dart';
import 'package:app/features/home/pages/scan_page.dart';

class HomePage extends HookWidget { 
  final Map<String, int> initialProducts;
  const HomePage({super.key, required this.initialProducts});

  @override
  Widget build(BuildContext context) {
    final scannedResults = useState<List<String>>([]);
    final products = useState<Map<String, int>>(initialProducts);
        
    // Function to process the scanned QR code
    Future<void> scanQRCode() async {
      final result = await Modular.to.push<String>(MaterialPageRoute(builder: (context) => const QRScannerPage()));
      if (result != null && result.isNotEmpty) {processScanned(context, result, products, scannedResults);}
    }

    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      endDrawer: DrawerScannerResult(scannedResults: scannedResults, products: products),

      body: Center(
        child: Column(
          children: [
            const Icon(Icons.qr_code_scanner, size: 100),
            const Text('Welcome to QR Scanner', style: TextStyle(fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: scanQRCode, child: const Text('Scan QR')),
                const SizedBox(width: 20),
                ElevatedButton(onPressed: () => Modular.to.pushNamed('/create'), child: const Text('Create QR')),
              ],
            ),

            const SizedBox(height: 20),
            const Text('Lista de products:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Display the list of products with their quantities
            ...products.value.entries.map((entry) => ProductCard(entry: entry)
            ),
            
          ],
        ),
      ),
    );
  }
}


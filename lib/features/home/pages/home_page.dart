import 'package:app/commons/widgets/qr_create_button.dart';
import 'package:app/commons/widgets/qr_scan_button.dart';
import 'package:app/commons/widgets/welcome_message.dart';
import 'package:app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:app/features/home/controllers/process_scanned.dart';
import 'package:app/features/home/widgets/drawer_scanner_result.dart';
import 'package:app/commons/widgets/qr_icon.dart';
import 'package:app/features/home/widgets/app_bar.dart';
import 'package:app/features/home/widgets/product_list.dart';
import 'package:app/features/home/pages/scan_page.dart';

class HomePage extends HookWidget {
  final Map<String, int> initialProducts;
  const HomePage({super.key, required this.initialProducts});

  @override
  Widget build(BuildContext context) {
    final scannedResults = useState<List<String>>([]);
    final products = useState<Map<String, int>>(initialProducts);

    Future<void> scanQRCode() async {
      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScannerPage()));
      if (result != null && result.isNotEmpty && context.mounted) {processScanned(context, result, products, scannedResults);}
    }

    return Scaffold(
      appBar: HomeAppBar(scannedResults: scannedResults),
      endDrawer: DrawerScannerResult(scannedResults: scannedResults, products: products),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        
        children: [
          // Welcome message
          QRIcon(iconSize: 100, iconData: Icons.qr_code_scanner,),
          const SizedBox(height: GuapliSizes.spaceBtwItems),
          WelcomeMessage(),
          const SizedBox(height: GuapliSizes.spaceBtwSections),

          // Buttons to scan and create QR codes
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QRScanButton(scanQRCode: scanQRCode),
              const SizedBox(width: GuapliSizes.defaultSpace),
              QRCreateButton(),
            ],
          ),
      
          const SizedBox(height: 20),
          const Text('Lista de products:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ProductList(products: products),
        ],
      ),
    );
  }
}






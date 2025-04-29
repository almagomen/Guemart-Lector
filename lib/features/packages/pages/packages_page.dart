import 'package:app/commons/models/packages_data.dart';
import 'package:app/commons/widgets/qr_scan_button.dart';
import 'package:app/features/home/controllers/process_scanned.dart';
import 'package:app/features/home/pages/home_page.dart';
import 'package:app/features/home/pages/scan_page.dart';
import 'package:app/features/home/widgets/app_bar.dart';
import 'package:app/features/home/widgets/drawer_scanner_result.dart';
import 'package:app/features/packages/widgets/product_list.dart';
import 'package:app/features/welcome/pages/packages_page.dart';
import 'package:app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PackagesPage extends HookWidget {

  const PackagesPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    
    void showPackageDetails(BuildContext context, String title, int index) {
      final packageProducts = packagesList[index];
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Paquete: $title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(initialProducts: packageProducts),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Processing'),
                ),
              ),
              const SizedBox(height: GuapliSizes.spaceBtwItems),
              Flexible(
                child: ProductList(products: ValueNotifier(packageProducts)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        ),
      );
    }
    


    return Scaffold(
      appBar: AppBar(title: const Text('Paquetes de Ropa')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PackageCard(
              title: 'Paquete Básico',
              description: 'Ropa esencial para el día a día',
              items: packagesList[0].length,
              onTap: () => showPackageDetails(context, 'Básico', 0),
            ),
            const SizedBox(height: GuapliSizes.spaceBtwItems),

            PackageCard(
              title: 'Paquete Premium',
              description: 'Colección exclusiva de temporada',
              items: packagesList[1].length,
              onTap: () => showPackageDetails(context, 'Premium', 1),
            ),
            const SizedBox(height: GuapliSizes.spaceBtwItems),
            
            PackageCard(
              title: 'Paquete Deluxe',
              description: 'Colección completa con accesorios',
              items: packagesList[2].length,
              onTap: () => showPackageDetails(context, 'Deluxe', 2),
            ),
          ],
        ),
      ),
    );
  }
}
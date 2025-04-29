import 'package:app/commons/models/packages_data.dart';
import 'package:app/features/packages/widgets/product_list.dart';
import 'package:app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class PackagesPage extends StatelessWidget {
  const PackagesPage({super.key});

  void _showPackageDetails(BuildContext context, String title, int index) {
    // Obtener el paquete correspondiente según el índice
    final packageProducts = packagesList[index];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Paquete: $title'),
        content: ProductList(products: ValueNotifier(packageProducts)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              onTap: () => _showPackageDetails(context, 'Básico', 0),
            ),
            const SizedBox(height: GuapliSizes.spaceBtwItems),

            PackageCard(
              title: 'Paquete Premium',
              description: 'Colección exclusiva de temporada',
              items: packagesList[1].length,
              onTap: () => _showPackageDetails(context, 'Premium', 1),
            ),
            const SizedBox(height: GuapliSizes.spaceBtwItems),
            
            PackageCard(
              title: 'Paquete Deluxe',
              description: 'Colección completa con accesorios',
              items: packagesList[2].length,
              onTap: () => _showPackageDetails(context, 'Deluxe', 2),
            ),
          ],
        ),
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  final String title;
  final String description;
  final int items;
  final VoidCallback onTap;

  const PackageCard({
    super.key,
    required this.title,
    required this.description,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '$items prendas',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

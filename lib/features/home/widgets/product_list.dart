
import 'package:app/features/home/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final ValueNotifier<Map<String, int>> products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          products.value.entries
              .map((entry) => ProductCard(entry: entry))
              .toList(),
    );
  }
}
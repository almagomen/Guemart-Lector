import 'package:flutter/material.dart';

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

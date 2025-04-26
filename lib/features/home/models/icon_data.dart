import 'package:flutter/material.dart';

IconData getProductIcon(String productName) {
  switch (productName.toLowerCase()) {
    case 'lente': return Icons.visibility;
    case 'gorra': return Icons.sports_motorsports;
    case 'camisa': return Icons.checkroom;
    case 'pantalon': return Icons.work;
    case 'guante': return Icons.handshake;
    default: return Icons.shopping_bag; 
  }
}
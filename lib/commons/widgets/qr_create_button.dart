import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class QRCreateButton extends StatelessWidget {
  const QRCreateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Modular.to.pushNamed('/create'),
      child: const Text('Create QR'),
    );
  }
}
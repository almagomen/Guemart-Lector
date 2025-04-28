import 'package:flutter/material.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text('Welcome to QR Scanner', style: Theme.of(context).textTheme.headlineMedium);
  }
}

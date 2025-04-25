import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Center(
        child: Column(
          children: [
            Icon(Icons.qr_code_scanner, size: 100),
          ],
        ),
      ),
    );
  }
}
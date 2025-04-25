import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:app/features/home/pages/home_page.dart';
import 'package:app/features/home/pages/create_page.dart';
// import 'package:app/features/home/pages/scan_page.dart';


void main(){
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      title: 'Scan QR',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: Modular.routerConfig,
    );
  }
}

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage());
    // r.child('/scan', child: (context) => ScanPage());
    r.child('/create', child: (context) => CreatePage());
  }
}






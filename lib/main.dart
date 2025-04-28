import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:app/utils/theme/theme.dart';

import 'package:app/features/home/pages/home_page.dart';
import 'package:app/features/home/pages/create_page.dart';
import 'package:app/features/home/models/data_products.dart';



void main(){
  debugPaintSizeEnabled = false; // Disable the debug paint size
  debugPaintLayerBordersEnabled = false; // Disable the debug paint layer borders
  debugPaintBaselinesEnabled = false; // Disable the debug paint baselines
  debugPaintPointersEnabled = false; // Disable the debug paint pointers
  debugRepaintRainbowEnabled = false; // Disable the debug repaint rainbow

  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      title: 'Scan QR',
      theme: GuapliAppTheme.lightTheme,
      darkTheme: GuapliAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: Modular.routerConfig,
    );
  }
}

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage(initialProducts: products));
    r.child('/create', child: (context) => CreatePage());
  }
}






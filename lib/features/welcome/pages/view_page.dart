import 'package:app/features/packages/pages/packages_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ViewPage extends HookWidget {
  const ViewPage({super.key});
  
      List<Widget> _pages() => <Widget>[
      PackagesPage(),
      const Center(child: Text('Usuario', style: TextStyle(fontSize: 24))),
  ];


  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: _pages()[selectedIndex.value],

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.padding), label: 'Paquetes',),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Usuario',),
        ],
        
        currentIndex: selectedIndex.value,
        selectedItemColor: Colors.blue,
        onTap: (index) => selectedIndex.value = index,
      ),
    );
  }
}
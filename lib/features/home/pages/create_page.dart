import 'package:app/features/home/models/qr_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreatePage extends HookWidget { // Cambiado a HookWidget
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final qrData = useState('This is a simple QR code'); // Hook para manejar el estado

    return Scaffold(
      appBar: AppBar(title: const Text('Generador de QR')),
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          QrImageView(
          data: qrData.value,
          version: QrVersions.auto,
          size: 250,
          ),

          const SizedBox(height: 5),

          TextField(
            decoration: const InputDecoration(
              // border: OutlineInputBorder(),
              labelText: 'Ingrese texto para el QR',
            ),
            onChanged: (value) {qrData.value = value;},
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                qrHistoryNotifier.value = [...qrHistoryNotifier.value, value];
                qrHistoryNotifier.value = qrHistoryNotifier.value.map((e) => e).toList();                
              }
            },
          ),
                    
          const SizedBox(height: 20),

          Expanded(
            child:ValueListenableBuilder<List<String>>(
              valueListenable: qrHistoryNotifier,
              builder: (context, qrHistory, _) {
                return ListView.builder(
                  itemCount: qrHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(qrHistory[index]),
                      leading: QrImageView(
                        data: qrHistory[index],
                        version: QrVersions.auto,
                        size: 50,
                      ),
                    );
                  },
                );
              }
            ),
          ),

        ],
      ),
      ),
    );
  }
}
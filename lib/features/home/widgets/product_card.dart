import 'package:app/features/home/models/icon_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProductCard extends HookWidget {
  final MapEntry<String, int> entry;

  const ProductCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    // Controlador de animación
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );

    // Definición de las animaciones

    

    final positionAnimation = useMemoized(
      () {        
        return Tween<double>(begin: 0, end: -350).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
        );
      },
      [animationController],
    );

    final opacityAnimation = useMemoized(
      () => Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
      ),
      [animationController],
    );

        // Valor previo de entry.value
    final previousValue = useRef(entry.value);

    // Efecto para disparar la animación cuando entry.value disminuye
    useEffect(() {
      if (entry.value < previousValue.value) {
        animationController.reset(); // Reset the animation
        Future.delayed(const Duration(milliseconds: 300), () { // Agregar un delay de 500ms          
          animationController.forward(); // Start the animation
        });
      }
      previousValue.value = entry.value;
      return null;
    }, [entry.value]);

    // Construcción del widget
    return Card(
      color: entry.value == 0 ? Colors.lightGreen[100] : Colors.amber[100],
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      elevation: 0,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0), side: BorderSide.none),
        leading: Icon(getProductIcon(entry.key), color: Colors.blue),
        title: Text(entry.key.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w400)),
        trailing: Stack(
          alignment: Alignment.center,
          children: [
            // Ícono estático en la posición inicial
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blue,
              child: Text(
                '${entry.value}',
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            // Ícono animado que sube y se difumina
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, positionAnimation.value),
                  child: FadeTransition(
                    opacity: opacityAnimation,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: animationController.isAnimating ? Colors.red : Colors.blue, // Cambiar a rojo si está animando
                      child: Text(
                        '${entry.value}',
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}






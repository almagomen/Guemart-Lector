import 'package:app/commons/models/icon_data.dart';
import 'package:app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProductDetailsCard extends StatelessWidget {
  final MapEntry<String, int> product;

  const ProductDetailsCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(getProductIcon(product.key), color: Colors.blue, size: 32),
                const SizedBox(width: 16),
                Expanded(child: Text(product.key.toUpperCase(), style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),),),
              ],
            ),

            const SizedBox(height: GuapliSizes.spaceBtwItems),
            
            // Detalles del producto
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailRow(
                    icon: Icons.inventory,
                    label: 'Cantidad disponible:',
                    value: '${product.value}',
                  ),
                  const SizedBox(height: 16),
                  _DetailRow(
                    icon: Icons.category,
                    label: 'Categoría:',
                    value: 'General',
                  ),
                  const SizedBox(height: 16),
                  _DetailRow(
                    icon: Icons.update,
                    label: 'Última actualización:',
                    value: DateTime.now().toString().split('.')[0],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Botón de cerrar
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue[700]),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class ProductCard extends HookWidget {
  final MapEntry<String, int> entry;
  const ProductCard({super.key, required this.entry});

  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ProductDetailsCard(product: entry),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Controlador de animación
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );

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
      child: InkWell(
        onTap: () => _showDetails(context),
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
                        backgroundColor: animationController.isAnimating ? Colors.red : Colors.blue,
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
      ),
    );
  }
}






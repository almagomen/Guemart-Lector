import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeAppBar extends HookWidget implements PreferredSizeWidget {
  final ValueNotifier<List<String>> scannedResults;
  const HomeAppBar({super.key, required this.scannedResults});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );
    final animation = useMemoized(
      () => Tween<double>(begin: 1.0, end: 1.4).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      ),
      [controller],
    );

    useEffect(() {
      void listener() {
        if (scannedResults.value.isNotEmpty) {
          Future.delayed(const Duration(seconds: 1)).then((_) {
            controller.forward().then((_) => controller.reverse());
          });
        }
      }

      scannedResults.addListener(listener);
      return () => scannedResults.removeListener(listener);
    }, [scannedResults, controller]);

    return AppBar(
      // title: const Text('QR Scanner'),
      actions: [
        Builder(
          builder: (context) => Stack(
            children: [
              ScaleTransition(
                scale: animation,
                child: IconButton(
                  icon: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(-1.0, 1.0), // Flip horizontally
                    child: const Icon(Icons.barcode_reader),
                  ),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
              if (scannedResults.value.isNotEmpty)
                Positioned(
                  right: 5,
                  top: 5,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${scannedResults.value.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
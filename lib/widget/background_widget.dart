import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.4, 0.9],
          colors: [
            Color.fromARGB(255, 219, 250, 241),
            Color.fromARGB(255, 192, 255, 229),
            Colors.white,
          ],
        ),
      ),
      child: child,
    );
  }
}

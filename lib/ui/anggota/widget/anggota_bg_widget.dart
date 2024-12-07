import 'package:flutter/material.dart';

class AnggotaBackground extends StatelessWidget {
  final Widget child;

  const AnggotaBackground({
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
            Color.fromARGB(255, 181, 255, 234),
            Color.fromARGB(255, 173, 255, 221),
            Colors.white,
          ],
        ),
      ),
      child: child,
    );
  }
}

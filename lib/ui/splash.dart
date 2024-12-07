import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/resource/resource.dart';
import 'package:mob3_uas_klp_05/ui/introduction.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

     Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroPage()),
      );
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo splash screen
            Image.asset(
              logo,
              height: 160,
            ),
            const SizedBox(height: 20),
            // Teks utama
            const Text(
              'Aplikasi BKTP\nKoperasi Peminjaman Asuransi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            // Teks dengan efek kilauan
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: const [Colors.white, Colors.yellow, Colors.white],
                      stops: [
                        (_controller.value - 0.3).clamp(0.0, 1.0),
                        _controller.value,
                        (_controller.value + 0.3).clamp(0.0, 1.0),
                      ],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: child,
                );
              },
              child: const Text(
                'Mempermudah Pinjaman Anda',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

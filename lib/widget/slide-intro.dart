import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mob3_uas_klp_05/ui/auth/login.dart';

class IntroSlide extends StatelessWidget {
  final String lottiePath;
  final String title;
  final String description;
  final bool isLastSlide;

  const IntroSlide({
    super.key,
    required this.lottiePath,
    required this.title,
    required this.description,
    this.isLastSlide = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            lottiePath,
            width: 250,
            height: 250,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 20),
          // Judul dan Deskripsi
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 40),
          if (isLastSlide)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman login
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Next',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
        ],
      ),
    );
  }
}

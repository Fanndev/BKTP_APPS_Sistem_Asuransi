import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/resource/resource.dart';
import 'package:mob3_uas_klp_05/widget/slide-intro.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Menambahkan delay untuk slide otomatis
    Future.delayed(const Duration(seconds: 3), _autoSlide);
  }

  // Fungsi untuk melakukan auto slide ke halaman berikutnya
  void _autoSlide() {
    if (_currentIndex < 2) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double padding = width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: height * 0.1,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                    Future.delayed(const Duration(seconds: 3), _autoSlide);
                  },
                  children: const [
                    IntroSlide(
                      lottiePath: icon1,
                      title: 'Selamat datang di aplikasi BKTP!',
                      description:
                          'Temukan berbagai kemudahan dalam mengelola pinjaman Anda.',
                    ),
                    IntroSlide(
                      lottiePath: icon2,
                      title: 'Proses Cepat dan Mudah!',
                      description: 'Ajukan pinjaman dengan cepat, tanpa ribet.',
                    ),
                    IntroSlide(
                      lottiePath: icon3,
                      title: 'Bergabung dengan Kami!',
                      description:
                          'Segera daftar dan nikmati kemudahan layanan kami.',
                      isLastSlide: true,
                    ),
                  ],
                ),
                // Indikator
                Positioned(
                  bottom: height * 0.1,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      expansionFactor: 4,
                      spacing: 8,
                      activeDotColor: Colors.green,
                      dotColor: Colors.black12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/ui/anggota/aktivitas/aktivitas.dart';
import 'package:mob3_uas_klp_05/ui/anggota/product/product.dart';
import 'package:mob3_uas_klp_05/ui/anggota/settings/settings.dart';
import 'package:mob3_uas_klp_05/ui/anggota/home/home.dart';

class MainPageAnggota extends StatefulWidget {
  const MainPageAnggota({super.key});

  @override
  _MainPageAnggotaState createState() => _MainPageAnggotaState();
}

class _MainPageAnggotaState extends State<MainPageAnggota> {
  int _currentIndex = 0; // Index yang aktif pada BottomNavigationBar
  final List<Widget> _pages =  [
    HomePageAnggota(),
    AktivitasPage(),
    ProdutAnggotaPage(),
    SettingsPage()
  ];

  // Fungsi untuk mengganti halaman berdasarkan index
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Aktivitas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: "Asuransi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Saya",
          ),
        ],
      ),
    );
  }
}

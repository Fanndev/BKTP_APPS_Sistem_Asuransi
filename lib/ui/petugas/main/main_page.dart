import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/ui/petugas/aktivitas/aktivitas.dart';
import 'package:mob3_uas_klp_05/ui/petugas/settings/settings.dart';
import 'package:mob3_uas_klp_05/ui/petugas/dashboard/dashboard.dart';

class MainPagePetugas extends StatefulWidget {
  const MainPagePetugas({super.key});

  @override
  _MainPagePetugasState createState() => _MainPagePetugasState();
}

class _MainPagePetugasState extends State<MainPagePetugas> {
  int _currentIndex = 0; // Index yang aktif pada BottomNavigationBar
  final List<Widget> _pages = const [
    DashboardPetugas(),
    AktivitasPage(),
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
            icon: Icon(Icons.dashboard),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Aktivitas",
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

import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/ui/admin/dashboard/dashboard.dart';

class MainPageAnggota extends StatefulWidget {
  const MainPageAnggota({super.key});

  @override
  _MainPageAnggotaState createState() => _MainPageAnggotaState();
}

class _MainPageAnggotaState extends State<MainPageAnggota> {
  int _currentIndex = 0; // Index yang aktif pada BottomNavigationBar
  final List<Widget> _pages = const [
    DashboardAdmin(),
    // TransaksiPage(),
    // AccountPage(),
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
        selectedItemColor: Colors.blue,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_outlined),
            label: "Transaksi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Akun",
          ),
        ],
      ),
    );
  }
}

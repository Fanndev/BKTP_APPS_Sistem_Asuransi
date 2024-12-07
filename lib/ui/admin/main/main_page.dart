import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/ui/admin/product/product.dart';
import 'package:mob3_uas_klp_05/ui/admin/dashboard/dashboard.dart';
import 'package:mob3_uas_klp_05/ui/admin/report/report.dart';
import 'package:mob3_uas_klp_05/ui/admin/settings/settings.dart';

class MainPageAdmin extends StatefulWidget {
  const MainPageAdmin({super.key});

  @override
  _MainPageAdminState createState() => _MainPageAdminState();
}

class _MainPageAdminState extends State<MainPageAdmin> {
  int _currentIndex = 0; // Index yang aktif pada BottomNavigationBar
  final List<Widget> _pages = [
     DashboardAdmin(),
     ProductPage(),
     ReportPage(),
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
            icon: Icon(Icons.insert_chart_outlined),
            label: "Product",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Report",
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

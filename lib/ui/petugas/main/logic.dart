import 'package:flutter/widgets.dart';
import 'package:mob3_uas_klp_05/ui/petugas/aktivitas/aktivitas.dart';
import 'package:mob3_uas_klp_05/ui/petugas/settings/settings.dart';
import 'package:mob3_uas_klp_05/ui/petugas/dashboard/dashboard.dart';

class PageLogic with ChangeNotifier {
  int _currentIndex = 0;

  // List halaman untuk BottomNavigationBar
  List<Widget> page = [
    const DashboardPetugas(),
    const AktivitasPage(),
     ProfilePage(),
  ];

  // Getter untuk currentIndex
  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners(); // Untuk memberi tahu perubahan
  }
}

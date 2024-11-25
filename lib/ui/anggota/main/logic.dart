import 'package:flutter/widgets.dart';
import 'package:mob3_uas_klp_05/ui/anggota/aktivitas/aktivitas.dart';
import 'package:mob3_uas_klp_05/ui/anggota/dashboard/dashboard.dart';
import 'package:mob3_uas_klp_05/ui/anggota/report/report.dart';
import 'package:mob3_uas_klp_05/ui/anggota/settings/settings.dart';

class PageLogic with ChangeNotifier {
  int _currentIndex = 0;

  // List halaman untuk BottomNavigationBar
  List<Widget> page = [
    const DashboardAnggota(),
    const AktivitasPage(),
    const ReportPage(),
    const SettingsPage(),
  ];

  // Getter untuk currentIndex
  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners(); // Untuk memberi tahu perubahan
  }
}

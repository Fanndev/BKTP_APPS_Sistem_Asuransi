import 'package:flutter/widgets.dart';
import 'package:mob3_uas_klp_05/ui/admin/product/product.dart';
import 'package:mob3_uas_klp_05/ui/admin/dashboard/dashboard.dart';
import 'package:mob3_uas_klp_05/ui/admin/report/report.dart';
import 'package:mob3_uas_klp_05/ui/admin/settings/settings.dart';

class PageLogic with ChangeNotifier {
  int _currentIndex = 0;

  // List halaman untuk BottomNavigationBar
  List<Widget> page =  [
     DashboardAdmin(),
     ProductPage(),
     ReportPage(),
     SettingsPage(),
  ];

  // Getter untuk currentIndex
  int get currentIndex => _currentIndex;

  // Fungsi untuk mengubah index
  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

import 'package:flutter/widgets.dart';
import 'package:mob3_uas_klp_05/ui/admin/dashboard/dashboard.dart';

class PageLogic with ChangeNotifier {
  int _currentIndex = 0;

  // List halaman untuk BottomNavigationBar
  List<Widget> page = [
    const DashboardAdmin(),
    // const TransaksiPage(),
    // const AccountPage(),
  ];

  // Getter untuk currentIndex
  int get currentIndex => _currentIndex;

  // Fungsi untuk mengubah index
  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners(); // Untuk memberi tahu perubahan
  }
}

import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/ui/petugas/report/resi.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<Map<String, dynamic>> activities = [
    {
      'title': 'Isi Saldo',
      'date': '13 Nov 2024 15:58',
      'amount': '+Rp21.203',
      'icon': Icons.account_balance_wallet,
    },
    {
      'title': 'Isi Saldo',
      'date': '11 Nov 2024 17:35',
      'amount': '+Rp71.203',
      'icon': Icons.account_balance_wallet,
    },
    {
      'title': 'Kirim Uang',
      'date': '19 Okt 2024 00:41',
      'amount': '-Rp88.203',
      'icon': Icons.send,
    },
    {
      'title': 'Shopee',
      'date': '11 Okt 2024 00:41',
      'amount': '-Rp98.203',
      'icon': 'shopee_logo',
    },
    {
      'title': 'Shopee',
      'date': '29 Sep 2024 00:41',
      'amount': '-Rp120.203',
      'icon': 'shopee_logo',
    },
    {
      'title': 'Kirim Uang',
      'date': '19 Sep 2024 00:41',
      'amount': '-Rp88.203',
      'icon': Icons.send,
    },
  ];

  String searchQuery = '';
  List<Map<String, dynamic>> filteredActivities = [];

  @override
  void initState() {
    super.initState();
    filteredActivities = activities;
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredActivities = activities.where((activity) {
        final title = activity['title'].toLowerCase();
        final date = activity['date'].toLowerCase();
        final queryLower = query.toLowerCase();
        return title.contains(queryLower) || date.contains(queryLower);
      }).toList();
    });
  }

  void openSettings() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.person, color: Colors.green),
                title: Text('Profil Pengguna'),
                onTap: () {
                  Navigator.pop(context);
                  // Tambahkan logika untuk mengelola profil
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.green),
                title: Text('Pengaturan Notifikasi'),
                onTap: () {
                  Navigator.pop(context);
                  // Tambahkan logika untuk notifikasi
                },
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.green),
                title: Text('Tentang Aplikasi'),
                onTap: () {
                  Navigator.pop(context);
                  // Tambahkan logika untuk informasi aplikasi
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Aktivitas', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: openSettings,
            icon: Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                onChanged: updateSearchQuery,
                decoration: InputDecoration(
                  hintText: 'Cari Aktivitas',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredActivities.length,
              itemBuilder: (context, index) {
                final activity = filteredActivities[index];

                bool isNewMonth = index == 0 ||
                    (index > 0 &&
                        activity['date'].split(' ')[1] !=
                            filteredActivities[index - 1]['date']
                                .split(' ')[1]);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isNewMonth)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        color: Colors.grey[300],
                        child: Center(
                          child: Text(
                            activity['date'].split(' ')[1] +
                                ' ' +
                                activity['date'].split(' ')[2],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ),
                      ),
                    ListTile(
                      leading: activity['icon'] == 'shopee_logo'
                          ? Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange[100],
                              ),
                              child: Image.asset(
                                'image/Shopee-logo.jpg',
                                fit: BoxFit.contain,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child:
                                  Icon(activity['icon'], color: Colors.green),
                            ),
                      title: Text(
                        activity['title'],
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        activity['date'],
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: Text(
                        activity['amount'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: activity['amount'].startsWith('+')
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReceiptPage(
                              receiptDetails: {
                                'date': activity['date'],
                                'amount': activity['amount'],
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    Divider(height: 1.0, color: Colors.grey[300]),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

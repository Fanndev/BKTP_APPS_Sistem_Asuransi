import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mob3_uas_klp_05/ui/petugas/report/resi.dart';

class AktivitasPage extends StatefulWidget {
  const AktivitasPage({super.key});

  @override
  _AktivitasPageState createState() => _AktivitasPageState();
}

class _AktivitasPageState extends State<AktivitasPage> {
  List<Map<String, dynamic>> activities = [];
  List<Map<String, dynamic>> filteredActivities = [];
  String searchQuery = '';
  String userId = '';

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  // Mengambil userId dari Firebase Authentication
  Future<void> _getUserId() async {
    try {
      final user = FirebaseAuth
          .instance.currentUser; // check pengguna yang sedang login
      if (user != null) {
        setState(() {
          userId = user.uid;
        });
        fetchActivities(userId); // Ambil aktivitas pengguna berdasarkan userId
      } else {
        print('Tidak ada pengguna yang terautentikasi.');
      }
    } catch (e) {
      print('Error getting user ID: $e');
    }
  }

  // Mengambil data aktivitas dari Firestore
  Future<void> fetchActivities(String userId) async {
    try {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final transactionsSnapshot =
          await userDoc.collection('transactions').get();

      if (transactionsSnapshot.docs.isEmpty) {
        print('Tidak ada transaksi');
      } else {
        setState(() {
          activities = transactionsSnapshot.docs.map((doc) {
            final data = doc.data();
            // data yg diambil
            return {
              'title': data['title'] ?? 'Transaksi Tidak Diketahui',
              'date': data['date'] ?? 'Tanggal Tidak Diketahui',
              'amount': data['amount'] ?? 'Rp0',
              'type': data['type'] ?? 'Lainnya',
            };
          }).toList();
          filteredActivities = activities;
        });
      }

      // Debug log untuk melihat data transaksi
      print('Fetched activities: $activities');
    } catch (e) {
      print('Error fetching activities: $e');
    }
  }

  // Fungsi untuk memperbarui query pencarian
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Aktivitas', style: TextStyle(color: Colors.white)),
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
                decoration: const InputDecoration(
                  hintText: 'Cari Aktivitas',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredActivities.isEmpty
                ? const Center(
                    child: Text('Tidak ada aktivitas yang ditemukan.'))
                : ListView.builder(
                    itemCount: filteredActivities.length,
                    itemBuilder: (context, index) {
                      if (filteredActivities.isEmpty) {
                        return const Center(
                            child: Text('Tidak ada aktivitas yang ditemukan.'));
                      }

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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                            leading: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.account_balance_wallet,
                                  color: Colors.green),
                            ),
                            title: Text(
                              activity['title'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              activity['date'], // Menampilkan tanggal transaksi
                              style: const TextStyle(color: Colors.grey),
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
                                  // Membuat halaman baru untuk menampilkan detail transaksi
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/ui/anggota/settings/settings.dart';
import 'package:mob3_uas_klp_05/ui/anggota/settings/DetailPage.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  _DataPageState createState() => _DataPageState();
}

// buat state untuk menyimpan hasil data
class _DataPageState extends State<DataPage> {
  final _usernameController = TextEditingController();
  final _noHPController = TextEditingController();
  final _emailController = TextEditingController();
  final _namaIbuKandungController = TextEditingController();
  final _pendidikanTerakhirController = TextEditingController();
  final _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Fungsi untuk mengambil data pengguna dari Firestore atau pengecekan login untuk menampilkan data yg ada
  void _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Anda harus login terlebih dahulu!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Mengambil data pengguna dari Firestore
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (docSnapshot.exists) {
        var data = docSnapshot.data() as Map<String, dynamic>;

        // Mengisi TextEditingController dengan data yang ada
        _usernameController.text = data['username'] ?? '';
        _noHPController.text = data['noHP'] ?? '';
        _emailController.text = data['email'] ?? '';
        _namaIbuKandungController.text = data['namaIbuKandung'] ?? '';
        _pendidikanTerakhirController.text = data['pendidikanTerakhir'] ?? '';
        _statusController.text = data['status'] ?? '';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengambil data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Fungsi untuk menyimpan atau memperbarui data pengguna
  void _simpanData() async {
    String username = _usernameController.text;
    String noHP = _noHPController.text;
    String email = _emailController.text;
    String namaIbuKandung = _namaIbuKandungController.text;
    String pendidikanTerakhir = _pendidikanTerakhirController.text;
    String status = _statusController.text;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Anda harus login terlebih dahulu!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Update data pengguna jika sudah ada
        await docRef.update({
          'username': username,
          'noHP': noHP,
          'email': email,
          'namaIbuKandung': namaIbuKandung,
          'pendidikanTerakhir': pendidikanTerakhir,
          'status': status,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data berhasil diperbarui!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Jika data pengguna tidak ada, buat data baru
        await docRef.set({
          'username': username,
          'noHP': noHP,
          'email': email,
          'namaIbuKandung': namaIbuKandung,
          'pendidikanTerakhir': pendidikanTerakhir,
          'status': status,
          'uid': user.uid,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data berhasil disimpan!'),
            backgroundColor: Colors.green,
          ),
        );
      }

      // Pindah ke halaman DataSummaryPage atau detail page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DataSummaryPage(documentId: user.uid),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
        ),
        title: const Center(
          child: Text('Informasi Pribadi'),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Informasi Pribadi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _noHPController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Nomor Ponsel',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 5),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Isi nomor ponsel Anda, jika perlu menghubungi Anda untuk verifikasi.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 5),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Bukti transaksi & tagihan akan dikirim ke email ini.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _namaIbuKandungController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Ibu Kandung',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _pendidikanTerakhirController,
                  decoration: const InputDecoration(
                    labelText: 'Pendidikan Terakhir',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _statusController,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _simpanData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Simpan Data',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

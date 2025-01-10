import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataSummaryPage extends StatelessWidget {
  final String documentId;

  DataSummaryPage({required this.documentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Data Pribadi'),
      ),
      // menampilkan ringkasan data
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(documentId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Terjadi kesalahan'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Data tidak ditemukan'));
          }

          var data = snapshot.data!;
          String username = data['username'];
          String noHP = data['noHP'];
          String email = data['email'];
          String namaIbuKandung = data['namaIbuKandung'];
          String pendidikanTerakhir = data['pendidikanTerakhir'];
          String status = data['status'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Lengkap: $username',
                    style: const TextStyle(fontSize: 18)),
                Text('Nomor Ponsel: $noHP',
                    style: const TextStyle(fontSize: 18)),
                Text('Email: $email', style: const TextStyle(fontSize: 18)),
                Text('Nama Ibu Kandung: $namaIbuKandung',
                    style: const TextStyle(fontSize: 18)),
                Text('Pendidikan Terakhir: $pendidikanTerakhir',
                    style: const TextStyle(fontSize: 18)),
                Text('Status: $status', style: const TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}

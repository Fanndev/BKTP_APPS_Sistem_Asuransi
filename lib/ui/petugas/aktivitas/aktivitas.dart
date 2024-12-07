import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/ui/petugas/aktivitas/Transaksi_tab.dart';
import 'package:mob3_uas_klp_05/ui/petugas/aktivitas/request_peminjaman_tab.dart';

class AktivitasPage extends StatelessWidget {
  const AktivitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Aktivitas"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Transaksi"),
              Tab(text: "Request Peminjaman"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Halaman Transaksi
            TransaksiTab(),
            // Halaman Request Peminjaman
            RequestPeminjamanTab(),
          ],
        ),
      ),
    );
  }
}

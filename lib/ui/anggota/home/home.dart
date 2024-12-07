import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/ui/anggota/widget/anggota_bg_widget.dart';
import 'package:mob3_uas_klp_05/ui/anggota/widget/card_widget.dart';

class HomePageAnggota extends StatelessWidget {
  const HomePageAnggota({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnggotaBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://via.placeholder.com/50'), // Gambar profil
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "James Howard",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications,
                          color: Colors.blueAccent),
                      onPressed: () {
                        // Aksi untuk notifikasi
                      },
                    ),
                  ],
                ),
              ),
              // Bagian Saldo
              Container(
                padding: const EdgeInsets.all(24.0),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Column(
                  children: [
                    Text(
                      "Total Pinjaman",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "IDR 12,490.20",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Tombol Aksi
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(Icons.send, "Send"),
                    _buildActionButton(Icons.add, "Buy"),
                    _buildActionButton(Icons.arrow_downward, "Receive"),
                  ],
                ),
              ),
              // Daftar Asuransi
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      AnsuransiCard(
                        title: "Asuransi Kesehatan",
                        status: "Aktif",
                        price: "Rp. 1.000.000",
                        onTap: () {
                          // Aksi ketika kartu ditekan
                        },
                      ),
                      AnsuransiCard(
                        title: "Asuransi Kendaraan",
                        status: "Nonaktif",
                        price: "Rp. 500.000",
                        onTap: () {
                          // Aksi ketika kartu ditekan
                        },
                      ),
                      AnsuransiCard(
                        title: "Asuransi Jiwa",
                        status: "Aktif",
                        price: "Rp. 2.000.000",
                        onTap: () {
                          // Aksi ketika kartu ditekan
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueAccent,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            iconSize: 30,
            onPressed: () {
              // Aksi untuk tombol
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.black87),
        ),
      ],
    );
  }
}

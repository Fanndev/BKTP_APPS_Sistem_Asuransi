import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/widget/background_widget.dart';
import 'package:mob3_uas_klp_05/widget/line_chart.dart';
import 'package:mob3_uas_klp_05/widget/stat_card.dart';

class DashboardPetugas extends StatelessWidget {
  const DashboardPetugas({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  children: [
                    Text(
                      "Selamat Datang Petugas",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A5568),
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.person,
                      size: 30,
                      color: Color(0xFF4A5568),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Kelola data klien dengan mudah dan cepat di Aplikasi BKTP",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A5568),
                  ),
                ),
                SizedBox(height: 25),

                // Statistics Cards
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        icon: Icons.people,
                        title: "Total Anggota",
                        value: "1,234",
                        color: Color(0xFF4299E1),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: StatCard(
                        icon: Icons.done_all,
                        title: "Pinjaman Selesai",
                        value: "456",
                        color: Color(0xFF48BB78),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        icon: Icons.loop,
                        title: "Pinjaman Aktif",
                        value: "789",
                        color: Color(0xFF4299E1),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: StatCard(
                        icon: Icons.cancel,
                        title: "Pinjaman Ditolak",
                        value: "123",
                        color: Color(0xFFF56565),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        icon: Icons.hourglass_top,
                        title: "Pinjaman Di Proses",
                        value: "789",
                        color: Color(0xFFED8936),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: StatCard(
                        icon: Icons.check_circle,
                        title: "Pinjaman Diterima",
                        value: "123",
                        color: Color(0xFF2F855A),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

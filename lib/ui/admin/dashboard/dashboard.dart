import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/widget/background_widget.dart';
import 'package:mob3_uas_klp_05/widget/line_chart.dart';
import 'package:mob3_uas_klp_05/widget/stat_card.dart';

class DashboardAdmin extends StatelessWidget {
  const DashboardAdmin({super.key});

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
                      "Selamat Datang Admin",
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
                        icon: Icons.account_balance_wallet,
                        title: "Pinjaman Aktif",
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
                        icon: Icons.check_circle,
                        title: "Pinjaman Lunas",
                        value: "789",
                        color: Color(0xFF9F7AEA),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: StatCard(
                        icon: Icons.payments,
                        title: "Angsuran Bulan Ini",
                        value: "Rp 45.6M",
                        color: Color(0xFFED8936),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),

                // Chart Section
                LineChartWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

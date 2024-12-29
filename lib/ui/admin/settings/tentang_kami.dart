import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/utils/colors.dart';

class TentangKamiPage extends StatelessWidget {
  const TentangKamiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.white,
      appBar: AppBar(
        title: const Text("Tentang Kami"),
        backgroundColor: MainColors.primary,
        foregroundColor: MainColors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tentang Aplikasi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Aplikasi BKTP Asuransi adalah sebuah platform yang dirancang '
              'untuk mempermudah proses klaim dan peminjaman asuransi bagi anggota. '
              'Dengan antarmuka yang sederhana dan fungsionalitas yang terintegrasi, '
              'aplikasi ini bertujuan memberikan pengalaman terbaik bagi pengguna '
              'dalam mengelola asuransi secara digital.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Tentang Pengembang',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Aplikasi ini dikembangkan oleh Mohamad Irfan Fadhlurrahman (Fanndev). '
              'Saya adalah seorang Developer Pemula yang tertarik dengan teknologi '
              'modern. Aplikasi ini dibuat sebagai bagian dari portofolio saya '
              'untuk menunjukkan kemampuan saya dalam mengembangkan aplikasi menggunakan '
              'teknologi modern seperti Flutter dan Firebase.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

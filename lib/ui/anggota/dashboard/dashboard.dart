import 'package:flutter/material.dart';

class DashboardAnggota extends StatelessWidget {
  const DashboardAnggota({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Anggota')),
      body: const Center(child: Text('Welcome Anggota')),
    );
  }
}

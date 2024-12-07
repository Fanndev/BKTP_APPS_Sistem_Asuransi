import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});

  final List<Map<String, dynamic>> reports = [
    {
      'name': 'M. Vito Anugrah Syahputra',
      'date': '27 Nov 2024',
      'insurance': 'Asuransi Jiwa A',
      'price': '-Rp30.000',
      'status': 'Disetujui oleh: Petugas 1',
    },
    {
      'name': 'Siti Hotimatu Sahro',
      'date': '27 Nov 2024',
      'insurance': 'Asuransi Jiwa B',
      'price': '+Rp100.000',
      'status': 'Disetujui oleh: Petugas 2',
    },
    {
      'name': 'DNID MOHXXX IRFXX',
      'date': '27 Nov 2024',
      'insurance': 'Asuransi Jiwa C',
      'price': '-Rp21.203',
      'status': 'Disetujui oleh: Petugas 3',
    },
    {
      'name': 'Harxx Darxx Putra',
      'date': '27 Nov 2024',
      'insurance': 'Asuransi Jiwa D',
      'price': '-Rp10.500',
      'status': 'Disetujui oleh: Petugas 4',
    },
    {
      'name': 'Yory Rizki Akbar',
      'date': '27 Nov 2024',
      'insurance': 'Asuransi Jiwa E',
      'price': '+Rp82.000',
      'status': 'Disetujui oleh: Petugas 5',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Asuransi'),
      ),
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                child: RandomAvatar(report['name'], trBackground: true),
              ),
              title: Text(report['name'], style: const TextStyle(fontSize: 1)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(report['date']),
                  Text(report['status']),
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    report['price'],
                    style: TextStyle(
                      color: report['price'].contains('-')
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(report['insurance']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

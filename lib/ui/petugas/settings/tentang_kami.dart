import 'package:flutter/material.dart';

class TentangKami extends StatefulWidget {
  @override
  _TentangKamiState createState() => _TentangKamiState();
}

class _TentangKamiState extends State<TentangKami> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Divider(),
          // Tentang Aplikasi
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.teal),
            title: Text('Tentang Aplikasi'),
            onTap: () {
              // Logika untuk membuka halaman tentang
              showAboutDialog(
                context: context,
                applicationName: 'BKTP',
                applicationVersion: '1.0.0',
                applicationIcon: Icon(Icons.app_settings_alt, size: 40),
                children: [
                  Text(
                      'Organisasi ekonomi yang dimiliki dan dioperasikan oleh sekelompok orang untuk kepentingan bersama. Koperasi peminjaman biasanya berfokus pada pelayanan keuangan seperti memberikan pinjaman kepada anggotanya'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

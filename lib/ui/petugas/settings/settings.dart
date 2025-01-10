import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mob3_uas_klp_05/ui/petugas/settings/edit_profile.dart';
import 'package:mob3_uas_klp_05/ui/petugas/settings/tentang_kami.dart';
import 'package:mob3_uas_klp_05/utils/themeNotifier.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = ThemeNotifier.of(context);
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              backgroundImage: CachedNetworkImageProvider(
                user?.photoURL ??
                    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.kompasiana.com%2Fisz.singa%2F54f83018a33311d25d8b46c3%2Fcaleg-yang-terinveksi-virus-doraemon&psig=AOvVaw2UaOs7trkSEXMiJT-8bFh8&ust=1734988351255000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCIiV7LSlvIoDFQAAAAAdAAAAABAE',
              ),
            ),
            const SizedBox(height: 15),
            Text(
              user?.displayName ?? 'Petugas',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              user?.email ?? 'Email tidak tersedia',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      themeNotifier?.isDarkMode ?? false
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: Colors.blueAccent,
                    ),
                    title: const Text('Mode Malam'),
                    trailing: Switch(
                      value: themeNotifier?.isDarkMode ?? false,
                      onChanged: themeNotifier?.toggleTheme,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading:
                        const Icon(Icons.settings, color: Colors.blueAccent),
                    title: const Text('Pengaturan'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TentangKami()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.redAccent),
                    title: const Text('Logout'),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit, color: Colors.green),
                    title: const Text('Edit Profil'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/widget/custom_list_tile.dart';
import 'package:mob3_uas_klp_05/ui/anggota/home/home.dart';
import 'package:mob3_uas_klp_05/ui/auth/login.dart';
import 'package:mob3_uas_klp_05/utils/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // Logout
  Future<void> logoutUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      ElegantNotification.success(
        title: const Text("Logout Berhasil"),
        description: const Text("Anda telah berhasil logout."),
      ).show(context);
      // Navigasi ke halaman login
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } catch (e) {
      ElegantNotification.error(
        title: const Text("Logout Gagal"),
        description: Text("Terjadi kesalahan: $e"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Akun Saya',
            style: TextStyle(
                color: MainColors.white, fontWeight: FontWeight.bold)),
        backgroundColor: MainColors.primary,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePageAnggota(),
                  ));
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: MainColors.primary,
              child: const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30.0,
                    child: Icon(
                      Icons.person,
                      size: 30.0,
                      color: MainColors.primary,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mohamad Irfan Fadhlurrahman',
                        style: TextStyle(
                          color: MainColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'fanndev@gmail.com',
                        style: TextStyle(
                          color: MainColors.white,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Account',
                    style: TextStyle(
                        color: MainColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CustomListTile(
                  icon: Icons.dashboard, title: 'Reset Password', onTap: () {}),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Bantuan',
                    style: TextStyle(
                        color: MainColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              CustomListTile(
                  icon: Icons.group, title: 'Tentang Kami', onTap: () {}),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'versi 1.0.0',
                style: TextStyle(
                    color: MainColors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => logoutUser(context),
                child: const Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: MainColors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Keluar',
                      style: TextStyle(color: MainColors.red),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

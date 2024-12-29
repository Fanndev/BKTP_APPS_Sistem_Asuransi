import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mob3_uas_klp_05/ui/petugas/settings/reset_password.dart';
import 'package:mob3_uas_klp_05/ui/petugas/settings/tentang_kami.dart';
import 'package:mob3_uas_klp_05/ui/petugas/settings/update_profile.dart';
import 'package:mob3_uas_klp_05/widget/custom_list_tile.dart';
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      ElegantNotification.error(
        title: const Text("Logout Gagal"),
        description: Text("Terjadi kesalahan: $e"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Akun Saya',
          style: TextStyle(
            color: MainColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: MainColors.primary,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateProfilePage(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: MainColors.primary,
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data?.data() == null) {
                    return const Text(
                      'Gagal memuat data',
                      style: TextStyle(color: Colors.white),
                    );
                  }

                  final userData =
                      snapshot.data?.data() as Map<String, dynamic>;

                  return Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30.0,
                        child: Icon(
                          Icons.person,
                          size: 30.0,
                          color: MainColors.primary,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData['username'] ?? 'Nama tidak tersedia',
                            style: const TextStyle(
                              color: MainColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            userData['email'] ?? 'Email tidak tersedia',
                            style: const TextStyle(
                              color: MainColors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ],
                  );
                },
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
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Account',
                    style: TextStyle(
                      color: MainColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomListTile(
                icon: Icons.dashboard,
                title: 'Reset Password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Bantuan',
                    style: TextStyle(
                      color: MainColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              CustomListTile(
                icon: Icons.group,
                title: 'Tentang Kami',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TentangKamiPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'versi 1.0.0',
                style: TextStyle(
                  color: MainColors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () => logoutUser(context),
                child: const Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: MainColors.red,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Keluar',
                      style: TextStyle(color: MainColors.red),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

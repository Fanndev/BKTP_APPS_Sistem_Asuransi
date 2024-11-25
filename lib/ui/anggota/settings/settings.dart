import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/ui/auth/login.dart';

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
        appBar: AppBar(title: const Text('Settings')),
        body: SafeArea(
            child: Center(
                child: ElevatedButton(
          onPressed: () => logoutUser(context),
          child: const Text('Logout'),
        ))));
  }
}

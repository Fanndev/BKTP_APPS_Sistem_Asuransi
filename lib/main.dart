import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:mob3_uas_klp_05/config/user_config.dart';
import 'package:mob3_uas_klp_05/ui/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Fungsi Config User
  // migrateExistingUsers();

  runApp(const BktpSistemApps());
}

class BktpSistemApps extends StatelessWidget {
  const BktpSistemApps({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BKTP Sistem Apps",
      home: SplashPage(),
    );
  }
}

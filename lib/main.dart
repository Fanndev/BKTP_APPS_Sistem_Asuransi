import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mob3_uas_klp_05/firebase_options.dart';
// import 'package:mob3_uas_klp_05/config/user_config.dart';
import 'package:mob3_uas_klp_05/ui/splash.dart';
import 'package:mob3_uas_klp_05/utils/themeNotifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Fungsi Config User
  // migrateExistingUsers();

  runApp(const BktpSistemApps());
}

class BktpSistemApps extends StatefulWidget {
  const BktpSistemApps({super.key});

  @override
  State<BktpSistemApps> createState() => _BktpSistemAppsState();
}

class _BktpSistemAppsState extends State<BktpSistemApps> {
  bool isDarkMode = false;
  @override

  Widget build(BuildContext context) {
    return ThemeNotifier(
      isDarkMode: isDarkMode,
      toggleTheme: (value) {
        setState(() {
          isDarkMode = value;
        });
      },
      child: MaterialApp(
        theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
        debugShowCheckedModeBanner: false,
        title: "BKTP Sistem Apps",
        home: SplashPage(),
      ),
    );
  }
}

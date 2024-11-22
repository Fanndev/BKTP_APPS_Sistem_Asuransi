import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void migrateExistingUsers() async {
  final List<Map<String, String>> users = [
    {
      'username': 'admin',
      'email': 'admin@gmail.com',
      'password': 'admin123',
      'role': 'admin',
    },
    {
      'username': 'petugas',
      'email': 'petugas@gmail.com',
      'password': 'petugas123',
      'role': 'petugas',
    },
    {
      'username': 'anggota',
      'email': 'anggota@gmail.com',
      'password': 'anggota123',
      'role': 'anggota',
    },
  ];

  for (var user in users) {
    try {
      // Buat akun di Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user['email']!,
        password: user['password']!,
      );

      // Simpan role ke Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': user['username'],
        'email': user['email'],
        'role': user['role'],
      });

      print('User ${user['email']} berhasil dimigrasikan.');
    } catch (e) {
      print('Gagal memigrasikan user ${user['email']}: $e');
    }
  }
}

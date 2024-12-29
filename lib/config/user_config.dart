import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void migrateExistingUsers() async {
  final List<Map<String, String>> users = [
    {
      'username': 'admin',
      'email': 'admin@gmail.com',
      'ktp': '2301010162',
      'phone': '08123456789',
      'gender': 'Laki-laki',
      'password': 'admin123',
      'role': 'admin',
    },
    {
      'username': 'petugas',
      'email': 'petugas@gmail.com',
      'ktp': '2301010162',
      'phone': '08123456789',
      'gender': 'Laki-laki',
      'password': 'petugas123',
      'role': 'petugas',
    },
    {
      'username': 'anggota',
      'email': 'anggota@gmail.com',
      'ktp': '2301010162',
      'phone': '08123456789',
      'gender': 'Laki-laki',
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
        'ktp': user['ktp'],
        'phone': user['phone'],
        'gender': user['gender'],
        'role': user['role'],
      });

      print('User ${user['email']} berhasil dimigrasikan.');
    } catch (e) {
      print('Gagal memigrasikan user ${user['email']}: $e');
    }
  }
}

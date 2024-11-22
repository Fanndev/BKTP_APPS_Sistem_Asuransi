import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mob3_uas_klp_05/resource/resource.dart';
import 'package:mob3_uas_klp_05/ui/admin/main/main_page.dart';
import 'package:mob3_uas_klp_05/ui/anggota/main/main_page.dart';
import 'package:mob3_uas_klp_05/ui/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:mob3_uas_klp_05/ui/petugas/main/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isPassword = true;
  final _formkey = GlobalKey<FormState>();

  // Fungsi untuk navigasi ke dashboard berdasarkan role
  void _navigateToDashboard(String role) {
    if (role == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPageAdmin(),
        ),
      );
    } else if (role == 'petugas') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPagePetugas(),
        ),
      );
    } else if (role == 'anggota') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPageAnggota(),
        ),
      );
    }
  }

  // Fungsi untuk menampilkan notifikasi error
  void _showErrorNotification(String message) {
    ElegantNotification.error(
      title: const Text("Login Failed"),
      description: Text(message),
    ).show(context);
  }

  // Fungsi untuk login
  Future<void> _login() async {
    if (_formkey.currentState!.validate()) {
      String emailValue = email.text.trim();
      String passwordValue = password.text.trim();

      try {
        // Login menggunakan Firebase Authentication
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailValue,
          password: passwordValue,
        );

        // Ambil UID pengguna
        String uid = userCredential.user!.uid;

        // Ambil data pengguna dari Firestore
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (userDoc.exists) {
          // Ambil role dari Firestore
          String role = userDoc.get('role');

          // Tampilkan notifikasi sukses
          ElegantNotification.success(
            title: const Text("Login Successful"),
            description: Text(
                "Welcome back! Anda login sebagai ${userDoc.get('username')}"),
          ).show(context);

          // Arahkan ke dashboard sesuai role
          _navigateToDashboard(role);
        } else {
          // Jika data pengguna tidak ditemukan di Firestore
          _showErrorNotification(
              'Data pengguna tidak ditemukan. Silakan periksa kembali email Anda.');
        }
      } on FirebaseAuthException catch (e) {
        // Tangani error dari Firebase Authentication
        if (e.code == 'user-not-found') {
          _showErrorNotification(
              'Email tidak ditemukan. Silakan periksa kembali email Anda atau daftarkan akun.');
        } else if (e.code == 'wrong-password') {
          _showErrorNotification(
              'Password salah. Pastikan Anda memasukkan password yang benar.');
        } else {
          _showErrorNotification('Terjadi kesalahan: saat Login');
        }
      } catch (e) {
        // Tangani error lainnya
        _showErrorNotification('Terjadi kesalahan: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(logo),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          // Input Email
                          TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              label: const Text(
                                "Email",
                                style: TextStyle(color: Colors.grey),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              fillColor: Colors.grey[200],
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(13),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Input Password
                          TextFormField(
                            controller: password,
                            obscureText: isPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              label: const Text(
                                "Password",
                                style: TextStyle(color: Colors.grey),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              fillColor: Colors.grey[200],
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPassword = !isPassword;
                                  });
                                },
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(13),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),

                          // Tombol Login
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: _login,
                              child: const Text("Login"),
                            ),
                          ),
                          const SizedBox(height: 5),

                          // Tombol ke Halaman Register
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Belum Punya Akun?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Register(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Daftar",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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

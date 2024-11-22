import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mob3_uas_klp_05/resource/resource.dart';
import 'package:mob3_uas_klp_05/ui/auth/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController noHP = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool isPassword = true;
  bool isValueInputname = false;
  bool isValueInputemail = false;
  bool isValueInputnoHP = false;
  final _formkey = GlobalKey<FormState>();

  void _registerUser() async {
    if (_formkey.currentState!.validate()) {
      if (password.text == confirmPassword.text) {
        try {
          // Mendaftarkan pengguna ke Firebase Authentication
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: email.text, password: password.text);

          // Dapatkan UID pengguna
          String uid = userCredential.user!.uid;
          print('User registered with UID: $uid'); // Debugging UID

          // Simpan data tambahan ke Cloud Firestore
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'username': username.text.trim(),
            'email': email.text.trim(),
            'noHP': noHP.text.trim(),
            'role': 'anggota', // Role default sebagai anggota
            'createdAt': DateTime.now().toIso8601String(),
          });

          ElegantNotification.success(
            title: const Text("Pendaftaran Sukses"),
            description: const Text("Kamu Berhasil Mendaftar Sebagai Anggota!"),
          ).show(context);

          // Navigasi ke halaman login
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        } on FirebaseAuthException catch (e) {
          // Tangani error saat pendaftaran
          String errorMessage = e.message ?? 'An error occurred';
          ElegantNotification.error(
            title: const Text("Pendaftaran Gagal"),
            description: Text(errorMessage),
          ).show(context);
        } on FirebaseException catch (e) {
          // Tangani error Firestore
          ElegantNotification.error(
            title: const Text("Firestore Error"),
            description: Text(e.message ?? 'Firestore permission denied'),
          ).show(context);
        } catch (e) {
          // Tangani error umum
          ElegantNotification.error(
            title: const Text("Unexpected Error"),
            description: Text(e.toString()),
          ).show(context);
        }
      } else {
        // Password dan confirm password tidak cocok
        ElegantNotification.error(
          title: const Text("Warning"),
          description: const Text("Password Kamu Tidak Cocok!"),
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(logo),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: username,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              setState(() {
                                isValueInputname = value.isNotEmpty;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              label: const Text(
                                "Username",
                                style: TextStyle(color: Colors.grey),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              fillColor: Colors.grey[200],
                              suffixIcon: isValueInputname
                                  ? const Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: Colors.green,
                                    )
                                  : null,
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
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              setState(() {
                                isValueInputemail = value.isNotEmpty;
                              });
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
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
                              suffixIcon: isValueInputemail
                                  ? const Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: Colors.green,
                                    )
                                  : null,
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
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: noHP,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                isValueInputnoHP = value.isNotEmpty;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Phone number';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              label: const Text(
                                "Phone number",
                                style: TextStyle(color: Colors.grey),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              fillColor: Colors.grey[200],
                              prefixText: "+62 | ",
                              suffixIcon: isValueInputnoHP
                                  ? const Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: Colors.green,
                                    )
                                  : null,
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
                          const SizedBox(
                            height: 20,
                          ),
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
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: confirmPassword,
                            obscureText: isPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Confirm Your Password';
                              }
                              if (value != confirmPassword.text) {
                                return 'Passwords Do Not Match';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              label: const Text(
                                "Confirm Password",
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
                            height: MediaQuery.of(context).size.height * 0.09,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                _registerUser();
                              },
                              child: const Text("Register"),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Sudah Punya Akun ?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                child: const Text("Login",
                                    style: TextStyle(color: Colors.green)),
                              ),
                            ],
                          ),
                        ],
                      ),
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

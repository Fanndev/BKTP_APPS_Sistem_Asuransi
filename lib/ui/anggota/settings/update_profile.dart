import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:mob3_uas_klp_05/widget/profile_item.dart';
import 'package:mob3_uas_klp_05/widget/section_title.dart';
import 'package:mob3_uas_klp_05/utils/colors.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _firestore = FirebaseFirestore.instance;

  Future<void> _updateField(String field, String initialValue) async {
    final controller = TextEditingController(text: initialValue);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Ubah $field",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: "Masukkan $field",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final newValue = controller.text.trim();
                  if (newValue.isNotEmpty) {
                    try {
                      final currentUser = FirebaseAuth.instance.currentUser;
                      await _firestore
                          .collection('users')
                          .doc(currentUser?.uid)
                          .update({field: newValue});

                      Navigator.pop(context);
                      ElegantNotification.success(
                        title: const Text("Sukses"),
                        description: Text('$field berhasil diperbarui!'),
                      ).show(context);
                    } catch (e) {
                      ElegantNotification.error(
                        title: const Text("Error"),
                        description: Text('Gagal memperbarui $field!'),
                      ).show(context);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: MainColors.primary,
                  foregroundColor: MainColors.white,
                ),
                child: const Text("Simpan"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showComingSoonDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Coming Soon"),
          content: const Text("Fitur ini belum tersedia."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text("Pengguna tidak ditemukan.")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Ubah Profil"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('users').doc(currentUser.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data?.data() == null) {
            return const Center(child: Text("Gagal memuat data pengguna."));
          }

          final userData = snapshot.data?.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Foto Profil Section
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _showComingSoonDialog,
                        child: const Text(
                          "Ubah Foto Profil",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Info Profil Section
                const SectionTitle(title: "Info Profil"),
                ProfileItem(
                  title: "Nama",
                  value: userData['username'] ?? "Belum diisi",
                  onTap: () =>
                      _updateField("username", userData['username'] ?? ""),
                  isEmpty: userData['username'] == null ||
                      userData['username'] == "",
                ),
                const SizedBox(height: 24),
                // Info Pribadi Section
                ProfileItem(
                  title: "E-mail",
                  value: userData['email'] ?? "Belum diisi",
                  onTap: () => _updateField("email", userData['email'] ?? ""),
                  isEmpty: userData['email'] == null || userData['email'] == "",
                ),
                ProfileItem(
                  title: "KTP",
                  value: userData['ktp'] ?? "Belum diisi",
                  onTap: () => _updateField("ktp", userData['ktp'] ?? ""),
                  isEmpty: userData['ktp'] == null || userData['ktp'] == "",
                ),
                ProfileItem(
                  title: "Nomor HP",
                  value: userData['phone'] ?? "Belum diisi",
                  onTap: () => _updateField("phone", userData['phone'] ?? ""),
                  isEmpty: userData['phone'] == null || userData['phone'] == "",
                ),
                ProfileItem(
                  title: "Jenis Kelamin",
                  value: userData['gender'] ?? "Belum diisi",
                  onTap: () => _updateField("gender", userData['gender'] ?? ""),
                  isEmpty:
                      userData['gender'] == null || userData['gender'] == "",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

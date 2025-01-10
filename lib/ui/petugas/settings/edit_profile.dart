import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = user?.displayName ?? '';
    _emailController.text = user?.email ?? '';
  }

  Future<void> _updateProfile() async {
    setState(() => _isLoading = true);
    try {
      if (_nameController.text.trim().isNotEmpty) {
        await user?.updateDisplayName(_nameController.text.trim());
      }
      if (_emailController.text.trim() != user?.email) {
        await _updateEmail();
      }
      await user?.reload();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil diperbarui')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateEmail() async {
    try {
      await user?.updateEmail(_emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email berhasil diperbarui')),
      );
    } catch (e) {
      if (e.toString().contains('requires-recent-login')) {
        await _reauthenticate();
      } else {
        rethrow;
      }
    }
  }

  Future<void> _reauthenticate() async {
    try {
      final password = await _askForPassword();
      if (password.isNotEmpty) {
        final credential = EmailAuthProvider.credential(
          email: user?.email ?? '',
          password: password,
        );
        await user?.reauthenticateWithCredential(credential);
        await _updateEmail();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reautentikasi gagal: ${e.toString()}')));
    }
  }

  Future<String> _askForPassword() async {
    String password = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Masukkan Kata Sandi'),
        content: TextField(
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Kata Sandi'),
          onChanged: (value) {
            password = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, password),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    return password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nama Tampilan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _updateProfile,
                    child: const Text('Simpan Perubahan'),
                  ),
          ],
        ),
      ),
    );
  }
}

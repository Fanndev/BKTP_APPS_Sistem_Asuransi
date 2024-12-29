import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;
  final bool isEmpty;

  const ProfileItem({
    required this.title,
    required this.value,
    required this.onTap,
    this.isEmpty = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value, overflow: TextOverflow.ellipsis),
      trailing: Icon(
        isEmpty ? Icons.error : Icons.check,
        color: isEmpty ? Colors.red : Colors.green,
      ),
      onTap: onTap,
    );
  }
}

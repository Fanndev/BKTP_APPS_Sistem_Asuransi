import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_05/utils/colors.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(
          icon,
          color: MainColors.primary,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: MainColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: MainColors.primary,
        ),
        onTap: onTap,
      ),
    );
  }
}

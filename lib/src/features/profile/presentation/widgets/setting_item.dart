import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF0F0F0), width: 1),
      ),
      child: ListTile(
        leading: Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            color: Color(0xFFF0F7FF),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(icon),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF333333),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xFFCCCCCC),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minLeadingWidth: 30,
      ),
    );
  }
}

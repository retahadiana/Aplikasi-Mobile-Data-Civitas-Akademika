import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = isDestructive ? const Color(0xFFCC3D3D) : const Color(0xFF2B3748);
    final Color iconBgColor = isDestructive
        ? const Color(0xFFFFEDEE)
        : const Color(0xFFEFF5FF);
    final Color iconColor = isDestructive
        ? const Color(0xFFCC3D3D)
        : const Color(0xFF2B7BE8);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EDF3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, color: textColor, fontSize: 15),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          size: 22,
          color: Color(0xFF9AA6B2),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
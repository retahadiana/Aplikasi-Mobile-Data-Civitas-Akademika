import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplikasimobile/features/profile/presentation/providers/profile_provider.dart';
import 'package:aplikasimobile/features/profile/presentation/widgets/profile_widget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.maybePop(context),
              )
            : null,
      ),
      body: profileState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (profile) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(profileNotifierProvider),
            child: ListView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 34,
                        backgroundColor: const Color(0xFFE6F0FF),
                        child: Text(
                          profile.nama.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF246BCE),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.nama,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              profile.nim,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey[500],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F1FF),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                profile.programStudi,
                                style: const TextStyle(
                                  color: Color(0xFF246BCE),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Informasi Kontak',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 12),
                _buildContactInfo(Icons.email_outlined, 'Email', profile.email),
                const SizedBox(height: 10),
                _buildContactInfo(Icons.phone_outlined, 'No. Telepon', profile.noHp),
                const SizedBox(height: 24),
                Text(
                  'Pengaturan',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 12),
                ProfileMenuItem(
                  icon: Icons.person_outline_rounded,
                  title: 'Edit Profil',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifikasi',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: Icons.lock_outline_rounded,
                  title: 'Keamanan',
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                ProfileMenuItem(
                  icon: Icons.logout_rounded,
                  title: 'Keluar',
                  isDestructive: true,
                  onTap: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6EAF0)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F6FC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF60758A), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF7A8794),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
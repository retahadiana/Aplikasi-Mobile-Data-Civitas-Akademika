import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplikasimobile/features/profile/presentation/providers/profile_provider.dart';
import 'package:aplikasimobile/features/profile/presentation/widgets/profile_widget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: profileState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (profile) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(profileNotifierProvider),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Header Profil
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.only(top: 60, bottom: 30),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue[700]!, Colors.blue[400]!],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Avatar
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blue[100],
                            child: Text(
                              profile.nama.substring(0, 1).toUpperCase(),
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue[700]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Nama & NIM
                        Text(
                          profile.nama,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          profile.nim,
                          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8)),
                        ),
                        const SizedBox(height: 8),
                        // Badge Prodi
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            profile.programStudi,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Info Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informasi Kontak',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        _buildContactInfo(Icons.email_outlined, 'Email', profile.email),
                        const SizedBox(height: 12),
                        _buildContactInfo(Icons.phone_outlined, 'No. Telepon', profile.noHp),

                        const SizedBox(height: 32),
                        const Text(
                          'Pengaturan',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 16),
                        ProfileMenuItem(
                          icon: Icons.logout_rounded,
                          title: 'Keluar',
                          isDestructive: true,
                          onTap: () {},
                        ),
                        const SizedBox(height: 40), // Spacing bawah
                      ],
                    ),
                  ),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
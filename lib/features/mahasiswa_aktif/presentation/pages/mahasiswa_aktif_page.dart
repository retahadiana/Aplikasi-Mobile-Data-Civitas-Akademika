import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplikasimobile/features/mahasiswa_aktif/presentation/providers/mahasiswa_aktif_provider.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mahasiswaAktifNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
            'Mahasiswa Aktif',
            style: TextStyle(fontWeight: FontWeight.bold)
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87, // Memberi aksen  untuk "Aktif"
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.read(mahasiswaAktifNotifierProvider.notifier).refresh(),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (listAktif) {

          if (listAktif.isEmpty) {
            return Center(
              child: Text(
                'Tidak ada mahasiswa aktif saat ini.',
                style: TextStyle(color: Colors.grey[600]),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(mahasiswaAktifNotifierProvider.notifier).refresh(),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: listAktif.length,
              itemBuilder: (context, index) {
                final item = listAktif[index];
                final badgeColor = item.id.isEven
                    ? const Color(0xFF4facfe)
                    : Colors.orange;

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: badgeColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'User ${item.userId}',
                              style: TextStyle(
                                color: badgeColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Post #${item.id}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.body,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 13,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
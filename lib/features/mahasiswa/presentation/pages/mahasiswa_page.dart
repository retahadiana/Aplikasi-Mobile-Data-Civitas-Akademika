import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplikasimobile/features/mahasiswa/presentation/providers/mahasiswa_provider.dart';
import 'package:aplikasimobile/features/mahasiswa/presentation/widgets/mahasiswa_widget.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
            'Data Mahasiswa',
            style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: -0.5)
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: mahasiswaState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (mahasiswaList) {
          return Column(
            children: [
              // HEADER BARU YANG LEBIH SOLID & KONTRAS
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Terdaftar',
                      style: TextStyle(
                        color: Colors.black87, // Warna hitam pekat agar pasti terlihat
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${mahasiswaList.length} Mahasiswa',
                        style: TextStyle(
                          color: Colors.blue[800], // Biru gelap agar sangat kontras
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Garis batas tipis
              Container(height: 1, color: Colors.grey.withOpacity(0.2)),

              // DAFTAR MAHASISWA
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => ref.invalidate(mahasiswaNotifierProvider),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    itemCount: mahasiswaList.length,
                    itemBuilder: (context, index) {
                      return ModernMahasiswaCard(
                        mahasiswa: mahasiswaList[index],
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Memilih ${mahasiswaList[index].nama}')),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
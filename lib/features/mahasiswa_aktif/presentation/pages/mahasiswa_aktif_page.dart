import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplikasimobile/features/mahasiswa_aktif/presentation/providers/mahasiswa_aktif_provider.dart';

// PENTING: Kita "meminjam" widget card dari fitur mahasiswa agar desain konsisten!
import 'package:aplikasimobile/features/mahasiswa/presentation/widgets/mahasiswa_widget.dart';

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
        foregroundColor: Colors.green[700], // Memberi aksen hijau untuk "Aktif"
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaAktifNotifierProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (listAktif) {

          // Tampilan jika kebetulan tidak ada mahasiswa yang aktif
          if (listAktif.isEmpty) {
            return Center(
              child: Text(
                'Tidak ada mahasiswa aktif saat ini.',
                style: TextStyle(color: Colors.grey[600]),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(mahasiswaAktifNotifierProvider),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: listAktif.length,
              itemBuilder: (context, index) {
                // Menggunakan widget yang sama persis dengan halaman Mahasiswa
                return ModernMahasiswaCard(mahasiswa: listAktif[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
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
      backgroundColor: Colors.grey[50], // Background yang lembut agar card menonjol
      appBar: AppBar(
        title: const Text('Data Mahasiswa', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaNotifierProvider),
          ),
        ],
      ),
      body: mahasiswaState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (mahasiswaList) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(mahasiswaNotifierProvider),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(), // Efek scroll memantul ala iOS
              padding: const EdgeInsets.all(20),
              itemCount: mahasiswaList.length,
              itemBuilder: (context, index) {
                return ModernMahasiswaCard(mahasiswa: mahasiswaList[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
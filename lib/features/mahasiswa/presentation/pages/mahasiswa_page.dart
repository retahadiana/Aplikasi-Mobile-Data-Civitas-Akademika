import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplikasimobile/features/mahasiswa/presentation/providers/mahasiswa_provider.dart';
import 'package:aplikasimobile/features/mahasiswa/presentation/widgets/mahasiswa_widget.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaNotifierProvider);
    final savedMahasiswa = ref.watch(savedMahasiswaProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Data Mahasiswa', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
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
      body: Column(
        children: [
          // Header Total Terdaftar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Terdaftar', style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.blue.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    mahasiswaState.maybeWhen(data: (list) => '${list.length} Mahasiswa', orElse: () => '...'),
                    style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          
          // --- KOTAK DATA LOCAL STORAGE ---
          _SavedMahasiswaSection(savedMahasiswa: savedMahasiswa, ref: ref),

          // Daftar Mahasiswa
          Expanded(
            child: mahasiswaState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
              data: (mahasiswaList) {
                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(mahasiswaNotifierProvider),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    itemCount: mahasiswaList.length,
                    itemBuilder: (context, index) {
                      final mhs = mahasiswaList[index];
                      return ModernMahasiswaCard(
                        mahasiswa: mhs,
                        // Gunakan onTap untuk memunculkan dialog simpan
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Simpan Mahasiswa?'),
                              content: Text('Simpan data ${mhs.name} secara offline?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.pop(ctx);
                                    await ref.read(mahasiswaNotifierProvider.notifier).saveSelectedMahasiswa(mhs);
                                    ref.invalidate(savedMahasiswaProvider);
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${mhs.name} disimpan!')));
                                    }
                                  },
                                  child: const Text('Simpan'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Widget Local Storage
class _SavedMahasiswaSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedMahasiswa;
  final WidgetRef ref;

  const _SavedMahasiswaSection({required this.savedMahasiswa, required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return savedMahasiswa.maybeWhen(
      data: (users) {
        if (users.isEmpty) return const SizedBox.shrink(); // Sembunyikan jika kosong
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange.shade200)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.offline_pin_rounded, color: Colors.orange.shade700, size: 18),
                        const SizedBox(width: 8),
                        Text('Tersimpan Offline (${users.length})', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange.shade900)),
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        await ref.read(mahasiswaNotifierProvider.notifier).clearSavedMahasiswa();
                        ref.invalidate(savedMahasiswaProvider);
                      },
                      child: const Text('Hapus Semua', style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              Divider(height: 1, color: Colors.orange.shade200),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final u = users[index];
                  return ListTile(
                    dense: true,
                    title: Text(u['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('ID: ${u['id']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.close, color: Colors.red, size: 18),
                      onPressed: () async {
                        await ref.read(mahasiswaNotifierProvider.notifier).removeSavedMahasiswa(u['id'] ?? '');
                        ref.invalidate(savedMahasiswaProvider);
                      },
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}
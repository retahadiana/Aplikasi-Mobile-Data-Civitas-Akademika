import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplikasimobile/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:aplikasimobile/features/mahasiswa/presentation/providers/mahasiswa_provider.dart';

class MahasiswaAktifNotifier extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final Ref ref;

  MahasiswaAktifNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadMahasiswaAktif();
  }

  Future<void> loadMahasiswaAktif() async {
    state = const AsyncValue.loading();
    try {
      // 1. Ambil repository dari provider mahasiswa yang sudah ada
      final repository = ref.read(mahasiswaRepositoryProvider);

      // 2. Ambil semua data mahasiswa
      final allMahasiswa = await repository.getMahasiswaList();

      // 3. FILTER: Ambil yang statusnya 'Aktif' saja
      final mahasiswaAktif = allMahasiswa.where((m) => m.status == 'Aktif').toList();

      state = AsyncValue.data(mahasiswaAktif);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await loadMahasiswaAktif();
  }
}

final mahasiswaAktifNotifierProvider = StateNotifierProvider.autoDispose<
    MahasiswaAktifNotifier, AsyncValue<List<MahasiswaModel>>>((ref) {
  return MahasiswaAktifNotifier(ref);
});
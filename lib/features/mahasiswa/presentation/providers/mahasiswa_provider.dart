import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aplikasimobile/core/services/local_storage_service.dart';
import 'package:aplikasimobile/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:aplikasimobile/features/mahasiswa/data/repositories/mahasiswa_repository.dart';

final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
});

final localStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

// Provider data mahasiswa yang disimpan di lokal
final savedMahasiswaProvider = FutureProvider<List<Map<String, String>>>((ref) async {
  final storage = ref.watch(localStorageProvider);
  return storage.getSavedMahasiswa();
});

class MahasiswaNotifier extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;
  final LocalStorageService _storage;

  MahasiswaNotifier(this._repository, this._storage) : super(const AsyncValue.loading()) {
    loadMahasiswaList();
  }

  Future<void> loadMahasiswaList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadMahasiswaList();
  }

  // --- Fungsi Simpan Local Storage ---
  Future<void> saveSelectedMahasiswa(MahasiswaModel mahasiswa) async {
    await _storage.addMahasiswaToSavedList(
      id: mahasiswa.id.toString(),
      name: mahasiswa.name,
    );
  }

  Future<void> removeSavedMahasiswa(String id) async {
    await _storage.removeSavedMahasiswa(id);
  }

  Future<void> clearSavedMahasiswa() async {
    await _storage.clearSavedMahasiswa();
  }
}

final mahasiswaNotifierProvider = StateNotifierProvider.autoDispose<MahasiswaNotifier, AsyncValue<List<MahasiswaModel>>>((ref) {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  final storage = ref.watch(localStorageProvider);
  return MahasiswaNotifier(repository, storage);
});